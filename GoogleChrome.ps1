Write-Output 'GoogleChrome Start'
$BuildDir = 'c:\CustomizerArtifacts'
if (-not(Test-Path $BuildDir)){
    New-Item -ItemType Directory $BuildDir
}

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls -bor [Net.SecurityProtocolType]::Tls11 -bor [Net.SecurityProtocolType]::Tls12
$allVersions = Get-GoogleChrome
$myVersion = $allVersions | Where-Object { $_.Architecture -eq 'x64'}
$fileName = split-path $myVersion.uri -Leaf

$outFile = join-path 'c:\CustomizerArtifacts' $fileName
if (-not(Test-Path $outFile)) {
    Invoke-WebRequest $myVersion.uri -OutFile $outFile
}

Start-Process -FilePath msiexec.exe -Argument "/i $outFile /quiet" -Wait
#Remove-Item $outFile
Write-Output 'GoogleChrome Installed'
