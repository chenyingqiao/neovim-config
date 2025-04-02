# nvim




# 关于 coc.preferences.jumpCommand
edit: 使用 :edit 命令打开文件，这是默认的行为，会替换当前窗口的内容。
split: 使用 :split 命令在新的水平分割窗口中打开文件。
vsplit: 使用 :vsplit 命令在新的垂直分割窗口中打开文件。
tabedit: 使用 :tabedit 命令在新的标签页中打开文件。
drop: 这是一个特殊的值，表示使用 Vim 的 :drop 命令，它会在当前窗口中打开文件，但保持当前光标位置不变。
buffer: 尝试在已有的缓冲区中打开文件，如果缓冲区不存在，则使用 edit 命令。
quickfix: 将跳转目标添加到快速修复列表中，然后使用 :copen 打开快速修复窗口。
location: 将跳转目标添加到位置列表中，然后使用 :lopen 打开位置列表窗口。
pedit: 使用 :pedit 命令打开预览窗口，适用于查看文件的一部分内容。
new: 尝试在新的缓冲区中打开文件，如果缓冲区已存在，则不打开新窗口。
lcd: 更改当前 Vim 会话的工作目录到跳转目标的目录。
tcd: 同 lcd，但用于终端缓冲区。



