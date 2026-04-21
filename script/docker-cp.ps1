# 将本地文件拷贝到 nvim 容器中
$CONTAINER = "nvim"
$SCRIPT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "Copying files to container: $CONTAINER"

docker cp $env:USERPROFILE\.claude ${CONTAINER}:/root/.claude
Write-Host "  [done] $env:USERPROFILE\.claude -> /root/.claude"

docker cp $env:USERPROFILE\.ssh ${CONTAINER}:/tmp/.ssh
Write-Host "  [done] $env:USERPROFILE\.ssh -> /tmp/.ssh"

docker cp $SCRIPT_DIR ${CONTAINER}:/tmp/script
Write-Host "  [done] $SCRIPT_DIR -> /tmp/script"

Write-Host "All files copied successfully."
