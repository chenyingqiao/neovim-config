@echo off
setlocal enabledelayedexpansion

cd /d "%~dp0script"
if exist "download-deps.bat" (
    call download-deps.bat
) else if exist "download-deps.ps1" (
    powershell -ExecutionPolicy Bypass -File download-deps.ps1
) else if exist "download-deps.sh" (
    echo Installing MSYS2 or WSL required to run bash scripts...
    powershell -ExecutionPolicy Bypass -Command "Write-Host 'Please install download-deps.bat or download-deps.ps1 in the script folder'"
)
cd /d "%~dp0"

echo === Docker Build Configuration ===
echo.

:platform
echo Select platform:
echo 1) linux/amd64
echo 2) linux/arm64
set /p platform_choice="Enter choice [1-2] (default: 1): "
if "!platform_choice!"=="2" (
    set "PLATFORM=linux/arm64"
) else (
    set "PLATFORM=linux/amd64"
)
echo Selected platform: !PLATFORM!
echo.

set /p enable_proxy="Enable proxy? [y/N] (default: N): "
set "BUILD_ARGS="

if /i "!enable_proxy!"=="y" (
    set /p proxy_addr="Enter proxy host:port (default: 127.0.0.1:7897): "
    set "PROXY_ADDR=!proxy_addr!:7897"
    if "!proxy_addr!"=="" set "PROXY_ADDR=127.0.0.1:7897"

    set /p use_socks="Use SOCKS5 for all_proxy? [Y/n] (default: Y): "
    if /i "!use_socks!"=="n" (
        set "ALL_PROXY=http://!PROXY_ADDR!"
    ) else (
        set "ALL_PROXY=socks5://!PROXY_ADDR!"
    )

    set "BUILD_ARGS=--build-arg https_proxy=http://!PROXY_ADDR! --build-arg http_proxy=http://!PROXY_ADDR! --build-arg all_proxy=!ALL_PROXY!"
    echo Proxy enabled: !PROXY_ADDR!
) else (
    echo Proxy disabled
)
echo.

set /p image_name="Enter image name (default: my-nvim): "
if "!image_name!"=="" set "image_name=my-nvim"
echo Image name: !image_name!
echo.

echo === Build Summary ===
echo Platform: !PLATFORM!
echo Image: !image_name!
if defined BUILD_ARGS (
    echo Proxy: enabled
) else (
    echo Proxy: disabled
)
echo.

set /p confirm="Proceed with build? [Y/n]: "
if /i "!confirm!"=="n" (
    echo Build cancelled.
    exit /b 0
)

echo.
echo Starting build...
echo.

docker buildx build --progress plain --load --platform "!PLATFORM!" !BUILD_ARGS! -t "!image_name!" -f Dockerfile-base ./

echo.
echo Build complete: !image_name!
