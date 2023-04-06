# Set the URL for the Chrome download
$chromeDownloadUrl = "https://dl.google.com/chrome/install/standalone/GoogleChromeStandaloneEnterprise64.msi"

# Set the path for the Chrome MSI file
$chromeMsiPath = "$($env:TEMP)\GoogleChromeStandaloneEnterprise64.msi"

# Download the Chrome MSI file
Invoke-WebRequest -Uri $chromeDownloadUrl -OutFile $chromeMsiPath

# Define the Chrome installation arguments
$chromeArgs = "/qn", "/norestart", "INSTALLLEVEL=1", "AP=""/installsource enterprisepolicy /prefetch:1""", "DEFAULT_BROWSER_AGENT=0"

# Install Chrome with the custom configuration options
Start-Process -FilePath msiexec.exe -ArgumentList "/i `"$chromeMsiPath`" $($chromeArgs -join ' ')" -Wait

# Clean up the Chrome MSI file
Remove-Item $chromeMsiPath
