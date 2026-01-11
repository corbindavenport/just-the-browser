#Requires -RunAsAdministrator

$OS = Get-CimInstance Win32_OperatingSystem
$BaseURL = "https://raw.githubusercontent.com/corbindavenport/just-the-browser/main/"
$MicrosoftEdgeInstallRegistry = "$BaseURL/edge/install.reg"
$MicrosoftEdgeUninstallRegistry = "$BaseURL/edge/uninstall.reg"
$GoogleChromeInstallRegistry = "$BaseURL/chrome/install.reg"
$GoogleChromeUninstallRegistry = "$BaseURL/chrome/uninstall.reg"
$FirefoxSettings = "$BaseURL/firefox/policies.json"

# Render initial interface for all pages
function Show-Header {
    Clear-Host
    Write-Host "`nJust the Browser ($($OS.Caption) Build $($OS.BuildNumber))`n========`n"
}

# Install Google Chrome settings
function Install-Chrome {
    Show-Header
    Write-Host "Downloading registry file, please wait..."
    # Download file
    try {
        Invoke-WebRequest $GoogleChromeInstallRegistry -OutFile "$env:LocalAppData\chrome.reg"
    }
    catch {
        Read-Host -Prompt "Download failed! Press Enter/Return to continue" | Out-Null
        Return
    }
    # Install file
    $ChromeInstall = Start-Process "reg.exe" -ArgumentList "import `"$env:LocalAppData\chrome.reg`"" -WindowStyle Hidden -Wait -PassThru
    if ($ChromeInstall.ExitCode -eq 0) {
        Read-Host -Prompt "Updated Google Chrome settings. Press Enter/Return to continue" | Out-Null
    } else {
        Read-Host -Prompt "Install failed! Press Enter/Return to continue" | Out-Null
    }
}

# Remove Google Chrome settings
function Uninstall-Chrome {
    Show-Header
    Write-Host "Downloading registry file, please wait..."
    # Download file
    try {
        Invoke-WebRequest $GoogleChromeUninstallRegistry -OutFile "$env:LocalAppData\chrome.reg"
    }
    catch {
        Read-Host -Prompt "Download failed! Press Enter/Return to continue" | Out-Null
        Return
    }
    # Install file
    $ChromeUninstall = Start-Process "reg.exe" -ArgumentList "import `"$env:LocalAppData\chrome.reg`"" -WindowStyle Hidden -Wait -PassThru
    if ($ChromeUninstall.ExitCode -eq 0) {
        Read-Host -Prompt "Removed Google Chrome settings. Press Enter/Return to continue" | Out-Null
    } else {
        Read-Host -Prompt "Remove failed! Press Enter/Return to continue" | Out-Null
    }
}

# Install Microsoft Edge settings
function Install-Edge {
    Show-Header
    Write-Host "Downloading registry file, please wait..."
    # Download file
    try {
        Invoke-WebRequest $MicrosoftEdgeInstallRegistry -OutFile "$env:LocalAppData\edge.reg"
    }
    catch {
        Read-Host -Prompt "Download failed! Press Enter/Return to continue" | Out-Null
        Return
    }
    # Install file
    $EdgeInstall = Start-Process "reg.exe" -ArgumentList "import `"$env:LocalAppData\edge.reg`"" -WindowStyle Hidden -Wait -PassThru
    if ($EdgeInstall.ExitCode -eq 0) {
        Read-Host -Prompt "Updated Microsoft Edge settings. Press Enter/Return to continue" | Out-Null
    } else {
        Read-Host -Prompt "Install failed! Press Enter/Return to continue" | Out-Null
    }
}

# Remove Microsoft Edge settings
function Uninstall-Edge {
    Show-Header
    Write-Host "Downloading registry file, please wait..."
    # Download file
    try {
        Invoke-WebRequest $MicrosoftEdgeUninstallRegistry -OutFile "$env:LocalAppData\edge.reg"
    }
    catch {
        Read-Host -Prompt "Download failed! Press Enter/Return to continue" | Out-Null
        Return
    }
    # Install file
    $EdgeUninstall = Start-Process "reg.exe" -ArgumentList "import `"$env:LocalAppData\edge.reg`"" -WindowStyle Hidden -Wait -PassThru
    if ($EdgeUninstall.ExitCode -eq 0) {
        Read-Host -Prompt "Removed Microsoft Edge settings. Press Enter/Return to continue" | Out-Null
    } else {
        Read-Host -Prompt "Remove failed! Press Enter/Return to continue" | Out-Null
    }
}

# Install Firefox settings
function Install-Firefox {
    Show-Header
    Write-Host "Downloading configuration file, please wait..."
    New-Item -ItemType Directory -Force -Path "$env:ProgramFiles\Mozilla Firefox\distribution" > $null
    try {
        Invoke-WebRequest $FirefoxSettings -OutFile "$env:ProgramFiles\Mozilla Firefox\distribution\policies.json"
        Read-Host -Prompt "Updated Firefox settings. Press Enter/Return to continue" | Out-Null
    }
    catch {
        Read-Host -Prompt "Download failed! Press Enter/Return to continue" | Out-Null
    }
}

# Remove Firefox settings
function Uninstall-Firefox {
    Show-Header
    Remove-Item -Path "$env:ProgramFiles\Mozilla Firefox\distribution\policies.json" -Force
    Read-Host -Prompt "Removed Firefox settings. Press Enter/Return to continue" | Out-Null
}

# Main menu selection
function Show-Menu {
    # Create list for menu options
    $options = New-Object System.Collections.Generic.List[psobject]
    # Google Chrome without settings applied
    $options.Add(@{
            Label  = "Google Chrome: Update settings"
            Action = { Install-Chrome }
        })
    # Google Chrome with settings applied
    $GoogleChromeCheck = Start-Process "reg.exe" -WindowStyle hidden -ArgumentList 'query "HKLM\SOFTWARE\Policies\Google\Chrome" /v "AIModeSettings"' -Wait -PassThru
    if ($GoogleChromeCheck.ExitCode -eq 0) {
        $options.Add(@{
                Label  = "Google Chrome: Remove settings"
                Action = { Uninstall-Chrome }
            })
    }
    # Microsoft Edge without settings applied
    $options.Add(@{
            Label  = "Microsoft Edge: Update settings"
            Action = { Install-Edge }
        })
    # Microsoft Edge with settings applied
    $MicrosoftEdgeCheck = Start-Process "reg.exe" -WindowStyle hidden -ArgumentList 'query "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "HideFirstRunExperience"' -Wait -PassThru
    if ($MicrosoftEdgeCheck.ExitCode -eq 0) {
        $options.Add(@{
                Label  = "Microsoft Edge: Remove settings"
                Action = { Uninstall-Edge }
            })
    }
    # Firefox without settings applied
    if (Test-Path "$env:ProgramFiles\Mozilla Firefox") {
        $options.Add(@{
                Label  = "Mozilla Firefox: Update settings"
                Action = { Install-Firefox }
            })
    }
    # Firefox with settings already applied
    if (Test-Path "$env:ProgramFiles\Mozilla Firefox\distribution\policies.json") {
        $options.Add(@{
                Label  = "Mozilla Firefox: Remove settings"
                Action = { Uninstall-Firefox }
            })
    }
    # Exit option
    $options.Add(@{
            Label = "Exit"; Action = { exit }
        })
    # Show main menu
    Show-Header
    Write-Host "Select an option by typing the number, then pressing Return/Enter on your keyboard to confirm.`n`nYou will need to restart your browser for changes to take effect.`n"
    for ($i = 0; $i -lt $options.Count; $i++) {
        Write-Host "[$($i + 1)] $($options[$i].Label)"
    }
    $selection = Read-Host "`n#"
    # Process menu selections
    if ($selection -match '^\d+$' -and $selection -le $options.Count) {
        $index = [int]$selection - 1
        & $options[$index].Action
        # Return to main menu after complete
        Show-Menu
    }
    else {
        Show-Menu
    }

}

Show-Menu