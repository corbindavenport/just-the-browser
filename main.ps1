#Requires -RunAsAdministrator

$OS = Get-CimInstance Win32_OperatingSystem
$BaseURL = "https://raw.githubusercontent.com/corbindavenport/just-the-browser/main/"
$MicrosoftEdgeInstallRegistryBase = "$BaseURL/edge/install-base.reg"
$MicrosoftEdgeInstallRegistrySearch = "$BaseURL/edge/install-search.reg"
$MicrosoftEdgeUninstallRegistry = "$BaseURL/edge/uninstall.reg"
$GoogleChromeInstallRegistry = "$BaseURL/chrome/install.reg"
$GoogleChromeUninstallRegistry = "$BaseURL/chrome/uninstall.reg"
$FirefoxInstallRegistry = "$BaseURL/firefox/install.reg"
$FirefoxUninstallRegistry = "$BaseURL/firefox/uninstall.reg"
$FirefoxSettings = "$BaseURL/firefox/policies.json"

# Render initial interface for all pages
function Show-Header {
    Clear-Host
    Write-Host "`nJust the Browser ($($OS.Caption) Build $($OS.BuildNumber))`n========`n"
}

# Remove Firefox JSON file if it exists, so it does not conflict with registry entries
# Previous versions of Just the Browser used the JSON method
function Uninstall-FirefoxJSON {
    Param(
        [Parameter(Position= 0, Mandatory= $true)]
        [String]$InstallPath
    )
    if (Test-Path "$InstallPath\distribution\policies.json") {
        Write-Host "Previous Firefox policies.json file found, deleting..."
        Remove-Item -Path "$InstallPath\distribution\policies.json" -Force
    }
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
    Write-Host "Downloading registry files, please wait..."
    # Download files in order: base settings first, search settings second
    try {
        Invoke-WebRequest $MicrosoftEdgeInstallRegistryBase -OutFile "$env:LocalAppData\edge-base.reg"
        Invoke-WebRequest $MicrosoftEdgeInstallRegistrySearch -OutFile "$env:LocalAppData\edge-search.reg"
    }
    catch {
        Read-Host -Prompt "Download failed! Press Enter/Return to continue" | Out-Null
        Return
    }
    # Install files in order to reduce search engine override risk
    $EdgeBaseInstall = Start-Process "reg.exe" -ArgumentList "import `"$env:LocalAppData\edge-base.reg`"" -WindowStyle Hidden -Wait -PassThru
    if ($EdgeBaseInstall.ExitCode -ne 0) {
        Read-Host -Prompt "Install failed! Press Enter/Return to continue" | Out-Null
        Return
    }
    $EdgeSearchInstall = Start-Process "reg.exe" -ArgumentList "import `"$env:LocalAppData\edge-search.reg`"" -WindowStyle Hidden -Wait -PassThru
    if ($EdgeSearchInstall.ExitCode -eq 0) {
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
    Param(
        [Parameter(Position= 0, Mandatory= $true)]
        [String]$InstallPath
    )
    Show-Header
    # Delete old JSON configuration if it exists
    Uninstall-FirefoxJSON "$InstallPath"
    # Download file
    Write-Host "Downloading registry file, please wait..."
    try {
        Invoke-WebRequest $FirefoxInstallRegistry -OutFile "$env:LocalAppData\firefox.reg"
    }
    catch {
        Read-Host -Prompt "Download failed! Press Enter/Return to continue" | Out-Null
        Return
    }
    # Install file
    $FirefoxInstall = Start-Process "reg.exe" -ArgumentList "import `"$env:LocalAppData\firefox.reg`"" -WindowStyle Hidden -Wait -PassThru
    if ($FirefoxInstall.ExitCode -eq 0) {
        Read-Host -Prompt "Updated Mozilla Firefox settings. Press Enter/Return to continue" | Out-Null
    } else {
        Read-Host -Prompt "Install failed! Press Enter/Return to continue" | Out-Null
    }
}

# Remove Firefox settings
function Uninstall-Firefox {
    Param(
        [Parameter(Position= 0, Mandatory= $true)]
        [String]$InstallPath
    )
    Show-Header
    # Delete old JSON configuration if it exists
    Uninstall-FirefoxJSON "$InstallPath"
    # Download file
    try {
        Invoke-WebRequest $FirefoxUninstallRegistry -OutFile "$env:LocalAppData\firefox.reg"
    }
    catch {
        Read-Host -Prompt "Download failed! Press Enter/Return to continue" | Out-Null
        Return
    }
    # Install file
    $FirefoxUninstall = Start-Process "reg.exe" -ArgumentList "import `"$env:LocalAppData\firefox.reg`"" -WindowStyle Hidden -Wait -PassThru
    if ($FirefoxUninstall.ExitCode -eq 0) {
        Read-Host -Prompt "Removed Mozilla Firefox settings. Press Enter/Return to continue" | Out-Null
    } else {
        Read-Host -Prompt "Remove failed! Press Enter/Return to continue" | Out-Null
    }
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
    if (Test-Path "HKLM:\SOFTWARE\Policies\Google\Chrome") {
        $GoogleChromeCheck = Get-ItemPropertyValue -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "AIModeSettings" -ErrorAction SilentlyContinue
        if ($null -ne $GoogleChromeCheck) {
            $options.Add(@{
                Label  = "Google Chrome: Remove settings"
                Action = { Uninstall-Chrome }
            })
        }
    }
    # Microsoft Edge without settings applied
    $options.Add(@{
            Label  = "Microsoft Edge: Update settings"
            Action = { Install-Edge }
        })
    # Microsoft Edge with settings applied
    if (Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge") {
        $MicrosoftEdgeCheck = Get-ItemPropertyValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Name "HideFirstRunExperience" -ErrorAction SilentlyContinue
        if ($null -ne $MicrosoftEdgeCheck) {
            $options.Add(@{
                Label  = "Microsoft Edge: Remove settings"
                Action = { Uninstall-Edge }
            })
        }
    }
    # Mozilla Firefox
    if (Test-Path "HKLM:\SOFTWARE\Mozilla\Mozilla Firefox") {
        # Find the current version installed, like: 147.0.1 (AArch64 en-US)
        $FirefoxVersion = Get-ItemPropertyValue -Path "HKLM:\SOFTWARE\Mozilla\Mozilla Firefox" -Name "CurrentVersion"
        # Find the registry values for the specified version
        if (Test-Path "HKLM:\SOFTWARE\Mozilla\Mozilla Firefox\$FirefoxVersion\Main") {
            # Finds the installation path, like: C:\Program Files\Mozilla Firefox
            $FirefoxPath = Get-ItemPropertyValue -Path "HKLM:\SOFTWARE\Mozilla\Mozilla Firefox\$FirefoxVersion\Main" -Name "Install Directory"
            # Firefox without settings alreay applied
            $options.Add(@{
                Label  = "Mozilla Firefox: Update settings"
                Action = { Install-Firefox "$FirefoxPath" }
            })
            # Firefox with settings already applied
            # This script previously used the JSON file for Firefox, so that must be checked in addition to the registry method
            if ((Test-Path "$FirefoxPath\distribution\policies.json") -or (Test-Path "HKLM:\SOFTWARE\Policies\Mozilla\Firefox\FirefoxHome")) {
                $options.Add(@{
                        Label  = "Mozilla Firefox: Remove settings"
                        Action = { Uninstall-Firefox "$FirefoxPath" }
                    })
            }
        }
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
