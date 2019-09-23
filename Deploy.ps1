Set-PSDebug -Trace 1

$appFolder = '/var/docker-deploy/completed-tasks'

docker-compose --no-ansi -f "$($appFolder)/docker-compose.yml" stop 2>&1
if ($LASTEXITCODE) {
    Exit $LASTEXITCODE
}

# replace the app
rm -rf "$($appFolder)/volumes/app"
mv app "$($appFolder)/volumes"

docker-compose --no-ansi -f "$($appFolder)/docker-compose.yml" up -d 2>&1
if ($LASTEXITCODE) {
    Exit $LASTEXITCODE
}
