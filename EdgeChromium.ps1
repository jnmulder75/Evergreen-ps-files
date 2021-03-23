Write-Output 'EdgeChromium Start'
$BuildDir = 'c:\CustomizerArtifacts'
if (-not(Test-Path $BuildDir)) {
    New-Item  -ItemType Directory $BuildDir
}
$allVersions = Get-MicrosoftEdge
$mostRecent = $allVersions | Sort-Object -Descending -Property 'Version' | Select-Object -First 1 | Select-Object -ExpandProperty 'Version'
$allOnVersion = $allVersions | Where-Object { $_.channel -eq 'Stable' }
$myVersion = $allOnVersion | Where-Object { $_.Architecture -eq 'x64' -and $_.Platform -eq 'Windows' -and $_.URI -like "*.msi"}

$fileName = split-path $myVersion.uri -Leaf
$outFile = join-path 'c:\CustomizerArtifacts' $fileName
if (-not(Test-Path $outFile)) {
    Invoke-WebRequest $myVersion.uri -OutFile $outFile
}
Start-Process -FilePath msiexec.exe -Argument "/i $outFile /quiet" -Wait
Remove-Item $outFile
Write-Output 'EdgeChromium Installed'
