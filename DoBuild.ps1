$build = (Get-ChildItem Env:BUILD_NUMBER).Value
$dockerVolumesPath = (Get-ChildItem Env:DOCKER_VOLUMES_PATH).Value

$outputPath = Join-Path $dockerVolumesPath 'output'
$srcPath = Join-Path $dockerVolumesPath 'src'

mkdir $outputPath
mv src $srcPath

docker run --rm -v "$($outputPath):/var/output" -v "$($srcPath):/var/src" mcr.microsoft.com/dotnet/core/sdk:2.2-alpine dotnet publish /var/src -c Release -f netcoreapp2.2 "/p:AssemblyVersion=$($build)"
if($LASTEXITCODE){
    Exit $LASTEXITCODE
}

mv "$($srcPath)/bin/Release/netcoreapp2.2/publish" app