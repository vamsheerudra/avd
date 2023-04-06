# Set the URL for the Notepad++ download
$notepadppDownloadUrl = "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.2.2/npp.8.2.2.Installer.x64.exe"

# Set the path for the Notepad++ installer file
$notepadppInstallerPath = "$($env:TEMP)\npp.8.2.2.Installer.x64.exe"

# Download the Notepad++ installer file
Invoke-WebRequest -Uri $notepadppDownloadUrl -OutFile $notepadppInstallerPath

# Define the Notepad++ installation arguments
$notepadppArgs = "/S", "/D=`"$($env:ProgramFiles)\Notepad++`"", "/NOICONS", "/NORESTART", "/COMPONENTS=""scintilla,nppFTP,Explorer,Updater,Git,PluginManager,Localization""", "/TASKS=""!npp""", "/DONTRESTART"

# Install Notepad++ with the custom configuration options
Start-Process -FilePath $notepadppInstallerPath -ArgumentList $($notepadppArgs -join ' ') -Wait

# Clean up the Notepad++ installer file
Remove-Item $notepadppInstallerPath
