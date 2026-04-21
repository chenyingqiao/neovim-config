# 将本地文件拷贝到 nvim-lerko 容器中
$CONTAINER = "nvim-lerko"
$SCRIPT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "Copying files to container: $CONTAINER"

docker cp $env:USERPROFILE\.claude ${CONTAINER}:/root/.claude
Write-Host "  [done] $env:USERPROFILE\.claude -> /root/.claude"

docker cp $env:USERPROFILE\.ssh ${CONTAINER}:/tmp/.ssh
Write-Host "  [done] $env:USERPROFILE\.ssh -> /tmp/.ssh"

docker cp $SCRIPT_DIR ${CONTAINER}:/tmp/script
Write-Host "  [done] $SCRIPT_DIR -> /tmp/script"

$PROJECT_DIR = Split-Path -Parent $SCRIPT_DIR
docker exec $CONTAINER mkdir -p /app/data
docker cp "$PROJECT_DIR\data\appsettings.json" ${CONTAINER}:/app/data/appsettings.json
Write-Host "  [done] $PROJECT_DIR\data\appsettings.json -> /app/data/appsettings.json"

Write-Host "All files copied successfully."
