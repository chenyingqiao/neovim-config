#!/usr/bin/env python3
"""
SyncClipboard Python客户端
支持文字、图片和文件的剪贴板同步
"""

import argparse
import base64
import hashlib
import json
import os
import sys
import time
import threading
from pathlib import Path
from typing import Optional

import requests
from requests.auth import HTTPBasicAuth


class ClipboardManager:
    """剪贴板管理器基类"""

    def get_text(self) -> Optional[str]:
        """获取剪贴板文本"""
        raise NotImplementedError

    def set_text(self, text: str):
        """设置剪贴板文本"""
        raise NotImplementedError

    def get_image(self) -> Optional[bytes]:
        """获取剪贴板图片"""
        raise NotImplementedError

    def set_image(self, image_data: bytes, filename: str):
        """设置剪贴板图片"""
        raise NotImplementedError


class LinuxClipboardManager(ClipboardManager):
    """Linux剪贴板管理器 (支持X11和Wayland)"""

    def __init__(self):
        # 检测可用的剪贴板工具
        self.use_wl = False
        try:
            import subprocess
            # 检测Wayland
            result = subprocess.run(['loginctl', 'show-session', "$(loginctl | grep $(whoami) | awk '{print $1}')", '-p', 'Type'],
                                  capture_output=True, text=True)
            self.use_wl = 'wayland' in result.stdout.lower()
        except:
            pass

    def get_text(self) -> Optional[str]:
        try:
            import subprocess
            if self.use_wl:
                result = subprocess.run(['wl-paste', '--no-newline'], capture_output=True, text=True)
            else:
                result = subprocess.run(['xclip', '-selection', 'clipboard', '-o'], capture_output=True, text=True)
            if result.returncode == 0:
                return result.stdout
        except Exception as e:
            print(f"获取剪贴板文本失败: {e}", file=sys.stderr)
        return None

    def set_text(self, text: str):
        try:
            import subprocess
            if self.use_wl:
                subprocess.run(['wl-copy'], input=text.encode(), check=True)
            else:
                subprocess.run(['xclip', '-selection', 'clipboard'], input=text.encode(), check=True)
        except Exception as e:
            print(f"设置剪贴板文本失败: {e}", file=sys.stderr)

    def get_image(self) -> Optional[bytes]:
        # Linux图片剪贴板支持较复杂，暂不实现
        return None

    def set_image(self, image_data: bytes, filename: str):
        # Linux图片剪贴板支持较复杂，暂不实现
        pass


class MacOSClipboardManager(ClipboardManager):
    """macOS剪贴板管理器"""

    def get_text(self) -> Optional[str]:
        try:
            import subprocess
            result = subprocess.run(['pbpaste'], capture_output=True, text=True)
            if result.returncode == 0:
                return result.stdout
        except Exception as e:
            print(f"获取剪贴板文本失败: {e}", file=sys.stderr)
        return None

    def set_text(self, text: str):
        try:
            import subprocess
            subprocess.run(['pbcopy'], input=text.encode(), check=True)
        except Exception as e:
            print(f"设置剪贴板文本失败: {e}", file=sys.stderr)

    def get_image(self) -> Optional[bytes]:
        try:
            import subprocess
            # macOS使用osascript获取图片
            script = '''
            tell application "System Events"
                try
                    set theData to the clipboard as «class PNGf»
                    return theData
                on error
                    return missing value
                end try
            end tell
            '''
            result = subprocess.run(['osascript', '-e', script], capture_output=True)
            if result.returncode == 0 and result.stdout:
                return result.stdout
        except Exception as e:
            print(f"获取剪贴板图片失败: {e}", file=sys.stderr)
        return None

    def set_image(self, image_data: bytes, filename: str):
        try:
            import subprocess
            # 将图片保存到临时文件然后复制
            import tempfile
            with tempfile.NamedTemporaryFile(suffix='.png', delete=False) as f:
                f.write(image_data)
                temp_path = f.name

            script = f'''
            set theFile to POSIX file "{temp_path}"
            set theData to read theFile as «class PNGf»
            set the clipboard to theData
            '''
            subprocess.run(['osascript', '-e', script], check=True)
            os.unlink(temp_path)
        except Exception as e:
            print(f"设置剪贴板图片失败: {e}", file=sys.stderr)


class WindowsClipboardManager(ClipboardManager):
    """Windows剪贴板管理器"""

    def get_text(self) -> Optional[str]:
        try:
            import win32clipboard
            win32clipboard.OpenClipboard()
            try:
                text = win32clipboard.GetClipboardData()
                return text
            finally:
                win32clipboard.CloseClipboard()
        except Exception as e:
            print(f"获取剪贴板文本失败: {e}", file=sys.stderr)
        return None

    def set_text(self, text: str):
        try:
            import win32clipboard
            win32clipboard.OpenClipboard()
            try:
                win32clipboard.EmptyClipboard()
                win32clipboard.SetClipboardText(text)
            finally:
                win32clipboard.CloseClipboard()
        except Exception as e:
            print(f"设置剪贴板文本失败: {e}", file=sys.stderr)

    def get_image(self) -> Optional[bytes]:
        try:
            import win32clipboard
            import io
            from PIL import Image

            win32clipboard.OpenClipboard()
            try:
                if win32clipboard.IsClipboardFormatAvailable(win32clipboard.CF_DIB):
                    data = win32clipboard.GetClipboardData(win32clipboard.CF_DIB)
                    image = Image.open(io.BytesIO(data))
                    output = io.BytesIO()
                    image.save(output, format='PNG')
                    return output.getvalue()
            finally:
                win32clipboard.CloseClipboard()
        except Exception as e:
            print(f"获取剪贴板图片失败: {e}", file=sys.stderr)
        return None

    def set_image(self, image_data: bytes, filename: str):
        try:
            import win32clipboard
            import io
            from PIL import Image

            image = Image.open(io.BytesIO(image_data))
            output = io.BytesIO()
            image.save(output, format='DIB')

            win32clipboard.OpenClipboard()
            try:
                win32clipboard.EmptyClipboard()
                win32clipboard.SetClipboardData(win32clipboard.CF_DIB, output.getvalue())
            finally:
                win32clipboard.CloseClipboard()
        except Exception as e:
            print(f"设置剪贴板图片失败: {e}", file=sys.stderr)


def get_clipboard_manager() -> ClipboardManager:
    """根据操作系统返回相应的剪贴板管理器"""
    import platform
    system = platform.system()

    if system == "Linux":
        return LinuxClipboardManager()
    elif system == "Darwin":
        return MacOSClipboardManager()
    elif system == "Windows":
        return WindowsClipboardManager()
    else:
        raise RuntimeError(f"不支持的操作系统: {system}")


def compute_hash(data: bytes) -> str:
    """计算数据的MD5哈希值"""
    return hashlib.md5(data).hexdigest()


class SyncClipboardClient:
    """SyncClipboard客户端"""

    def __init__(self, url: str, username: str, password: str, interval: float = 2.0):
        """
        初始化客户端

        Args:
            url: 服务器地址 (如: http://127.0.0.1:5033)
            username: 用户名
            password: 密码
            interval: 同步间隔（秒）
        """
        self.url = url.rstrip('/')
        self.auth = HTTPBasicAuth(username, password)
        self.interval = interval
        self.clipboard = get_clipboard_manager()

        # 状态跟踪
        self.last_text_hash = None
        self.last_file_hash = None
        self.running = False

    def get_remote_text(self) -> Optional[dict]:
        """获取远程剪贴板文本"""
        try:
            response = requests.get(
                f"{self.url}/SyncClipboard.json",
                auth=self.auth,
                timeout=5
            )
            if response.status_code == 200:
                return response.json()
            elif response.status_code == 401:
                print("认证失败：用户名或密码错误", file=sys.stderr)
            else:
                print(f"获取远程剪贴板失败: HTTP {response.status_code}", file=sys.stderr)
        except Exception as e:
            print(f"获取远程剪贴板失败: {e}", file=sys.stderr)
        return None

    def upload_text(self, text: str):
        """上传文本到服务器"""
        try:
            data = {
                "text": text,
                "hash": compute_hash(text.encode('utf-8'))
            }
            response = requests.put(
                f"{self.url}/SyncClipboard.json",
                auth=self.auth,
                json=data,
                timeout=5
            )
            if response.status_code == 200:
                print("✓ 文本已上传")
            else:
                print(f"上传文本失败: HTTP {response.status_code}", file=sys.stderr)
        except Exception as e:
            print(f"上传文本失败: {e}", file=sys.stderr)

    def get_remote_files(self) -> list:
        """获取远程文件列表"""
        try:
            # 通过WebDAV PROPFIND获取文件列表
            headers = {'Depth': '1'}
            response = requests.request(
                'PROPFIND',
                f"{self.url}/file/",
                auth=self.auth,
                headers=headers,
                timeout=5
            )
            if response.status_code == 207:
                # 解析WebDAV响应
                import xml.etree.ElementTree as ET
                root = ET.fromstring(response.content)
                files = []
                for elem in root.iter('{DAV:}href'):
                    path = elem.text
                    if path and path != '/file/':
                        filename = path.split('/')[-1]
                        if filename:
                            files.append(filename)
                return files
        except Exception as e:
            print(f"获取远程文件列表失败: {e}", file=sys.stderr)
        return []

    def download_file(self, filename: str) -> Optional[bytes]:
        """下载远程文件"""
        try:
            response = requests.get(
                f"{self.url}/file/{filename}",
                auth=self.auth,
                timeout=10
            )
            if response.status_code == 200:
                return response.content
            else:
                print(f"下载文件失败: HTTP {response.status_code}", file=sys.stderr)
        except Exception as e:
            print(f"下载文件失败: {e}", file=sys.stderr)
        return None

    def upload_file(self, filename: str, data: bytes):
        """上传文件到服务器"""
        try:
            response = requests.put(
                f"{self.url}/file/{filename}",
                auth=self.auth,
                data=data,
                timeout=10
            )
            if response.status_code == 200 or response.status_code == 201:
                print(f"✓ 文件 {filename} 已上传")
            else:
                print(f"上传文件失败: HTTP {response.status_code}", file=sys.stderr)
        except Exception as e:
            print(f"上传文件失败: {e}", file=sys.stderr)

    def sync_from_server(self):
        """从服务器同步到本地"""
        # 同步文本
        remote_data = self.get_remote_text()
        if remote_data and 'text' in remote_data:
            remote_text = remote_data['text']
            remote_hash = remote_data.get('hash')

            if remote_hash != self.last_text_hash:
                print(f"↓ 收到远程文本: {remote_text[:50]}...")
                self.clipboard.set_text(remote_text)
                self.last_text_hash = remote_hash

        # 文件同步暂不实现自动下载，避免频繁下载大文件

    def sync_to_server(self):
        """从本地同步到服务器"""
        # 同步文本
        local_text = self.clipboard.get_text()
        if local_text:
            local_hash = compute_hash(local_text.encode('utf-8'))

            # 检查远程是否有更新
            remote_data = self.get_remote_text()
            if remote_data:
                remote_hash = remote_data.get('hash')
                # 如果本地和远程都相同，不需要上传
                if local_hash == remote_hash:
                    self.last_text_hash = local_hash
                    return

            # 如果本地有变化，上传
            if local_hash != self.last_text_hash:
                print(f"↑ 上传本地文本: {local_text[:50]}...")
                self.upload_text(local_text)
                self.last_text_hash = local_hash

    def sync_once(self, direction: str = 'both'):
        """执行一次同步

        Args:
            direction: 'up'（仅上传）, 'down'（仅下载）, 'both'（双向）
        """
        if direction in ['up', 'both']:
            self.sync_to_server()
        if direction in ['down', 'both']:
            self.sync_from_server()

    def run(self):
        """持续运行同步"""
        self.running = True
        print(f"开始同步剪贴板 (间隔: {self.interval}秒)")
        print("按 Ctrl+C 停止")

        try:
            while self.running:
                self.sync_once('both')
                time.sleep(self.interval)
        except KeyboardInterrupt:
            print("\n停止同步")
            self.running = False


def main():
    parser = argparse.ArgumentParser(
        description='SyncClipboard Python客户端 - 跨平台剪贴板同步工具',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog='''
示例:
  # 使用默认配置运行
  %(prog)s

  # 指定服务器地址和认证信息
  %(prog)s --url http://192.168.1.100:5033 --username myuser --password mypass

  # 修改同步频率为5秒
  %(prog)s --interval 5

  # 仅执行一次同步（不同步）
  %(prog)s --once
        '''
    )

    parser.add_argument(
        '--url',
        default='http://127.0.0.1:5033',
        help='服务器地址 (默认: http://127.0.0.1:5033)'
    )

    parser.add_argument(
        '--username',
        default='admin',
        help='用户名 (默认: admin)'
    )

    parser.add_argument(
        '--password',
        default='admin',
        help='密码 (默认: admin)'
    )

    parser.add_argument(
        '--interval',
        type=float,
        default=2.0,
        help='同步间隔（秒）(默认: 2.0)'
    )

    parser.add_argument(
        '--once',
        action='store_true',
        help='仅执行一次同步后退出'
    )

    parser.add_argument(
        '--direction',
        choices=['up', 'down', 'both'],
        default='both',
        help='同步方向: up(仅上传), down(仅下载), both(双向) (默认: both)'
    )

    args = parser.parse_args()

    # 验证interval
    if args.interval < 0.1:
        print("错误: 同步间隔不能小于0.1秒", file=sys.stderr)
        sys.exit(1)

    # 创建客户端
    client = SyncClipboardClient(
        url=args.url,
        username=args.username,
        password=args.password,
        interval=args.interval
    )

    if args.once:
        # 执行一次同步
        print("执行一次同步...")
        client.sync_once(args.direction)
    else:
        # 持续运行
        client.run()


if __name__ == '__main__':
    main()