Write-Output 'Citrix Workspace App Start'
$BuildDir = 'c:\CustomizerArtifacts'
if (-not(Test-Path $BuildDir)){
    New-Item -ItemType Directory $BuildDir
}
$allVersions = Get-CitrixWorkspaceApp
$mostRecent = $allVersions | Sort-Object -Descending -Property 'Version' | Select-Object -First 1 | Select-Object -ExpandProperty 'Version'
$allOnVersion = $allVersions | Where-Object { $_.version -eq $mostRecent }

$fileName = split-path $allOnVersion.uri -Leaf -Verbose
$outFile = join-path 'c:\CustomizerArtifacts' 'CitrixWorkspaceApp.exe'
Invoke-WebRequest $allOnVersion.uri -OutFile $outFile

#Start-Process -FilePath (Join-Path $BuildDir "CitrixWorkspaceApp.exe") -Argument '/silent /AutoUpdateCheck=disabled /noreboot' -Wait
#Remove-Item $outFile
#Write-Output 'Citrix Workspace App Installed'
