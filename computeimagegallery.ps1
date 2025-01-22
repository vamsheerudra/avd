#Install RSAT
#Add-WindowsCapability -Online -Name "Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0"
#Start-Process -FilePath "DISM.exe" -ArgumentList "/Online /Add-Capability /CapabilityName:Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0"

#Download software
New-Item -ItemType Directory -Path "c:\temp" -Force
New-Item -ItemType Directory -Path "c:\temp\Teams" -Force
Invoke-WebRequest -Uri 'https://download.microsoft.com/download/8/8/0/880BCA75-79DD-466A-927D-1ABF1F5454B0/PBIDesktopSetup_x64.exe' -OutFile 'C:\temp\PBIDesktopSetup_x64.exe'
Invoke-WebRequest -Uri 'https://go.microsoft.com/fwlink/?linkid=2243204&clcid=0x409' -OutFile 'C:\temp\Teams\teamsbootstrapper.exe'
Invoke-WebRequest -Uri 'https://go.microsoft.com/fwlink/?linkid=2196106' -OutFile 'C:\temp\Teams\MSTeams-x64.msix'

#echo "Installing applications using winget"
#https://winget.run/. Add IDs of updates to run
$Allowlist = @(
'Google.Chrome',
'Mozilla.Firefox',
#'KeePassXCTeam.KeePassXC',
#'Microsoft.Edge',
#'mRemoteNG.mRemoteNG',
'Notepad++.Notepad++',
'Oracle.JavaRuntimeEnvironment',
'Python.Python.3.11',
'PuTTY.PuTTY',
'WinSCP.WinSCP'
)

Function Get-WingetPath {
    param() 
    if(([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    $resolveWingetPath = Resolve-Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_*_x64__8wekyb3d8bbwe"
    $wingetPath = $ResolveWingetPath[-1].Path
    $winget= Join-Path -Path $wingetPath -ChildPath "winget.exe"
 }
    else {
            $wingetPath = Get-Command winget.exe -ErrorAction SilentlyContinue
            $winget = $wingetPath.Source
    } 
    return $winget
 }

$winget = Get-WingetPath

# Run through the WinGet list, compare with the Allow list, and execute the upgrade
foreach($App in $Allowlist){
  &$winget install --exact $App --scope machine --force --accept-package-agreements --accept-source-agreements --source winget
}

Invoke-WebRequest -Uri "https://raw.githubusercontent.com/PetterTech/DemoStuff/main/AzureImageBuilderScripts/Install-PowerShell.ps1" -OutFile "C:\temp\Install-PowerShell.ps1"
C:\temp\Install-PowerShell.ps1


