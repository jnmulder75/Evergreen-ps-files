Write-Output 'DotNET Start'
$BuildDir = 'c:\CustomizerArtifacts'
if (-not(Test-Path $BuildDir)){
    New-Item -ItemType Directory $BuildDir
}
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls -bor [Net.SecurityProtocolType]::Tls11 -bor [Net.SecurityProtocolType]::Tls12
$allVersions = Get-Microsoft.NET
$mostRecent = $allVersions | Sort-Object -Descending -Property 'Version' | Select-Object -First 1 | Select-Object -ExpandProperty 'Version'
$allOnVersion = $allVersions | Where-Object { $_.channel -eq 'Current' }
$myVersion = $allOnVersion | Where-Object { $_.Architecture -eq 'x64'}
$fileName = split-path $myVersion.uri -Leaf

$outFile = join-path 'c:\CustomizerArtifacts' 'windowsdesktop-runtime-win-x64.exe'
if (-not(Test-Path $outFile)) {
    Invoke-WebRequest $myVersion.uri -OutFile $outFile
}
Start-Process $outFile -Argument '/install /quiet /norestart' -Wait

#Remove-Item $outFile
Write-Output 'DotNET Installed'
