#Requires -RunAsAdministrator

$OS = Get-CimInstance Win32_OperatingSystem
$BaseURL = "https://raw.githubusercontent.com/corbindavenport/just-the-browser/HEAD/"
$FirefoxSettings = "$BaseURL/firefox/policies.json"

# Render initial interface for all pages
function Show-Header {
    Clear-Host
    Write-Host "`nJust the Browser ($($OS.Caption) Build $($OS.BuildNumber))`n========`n"
}

# Install Firefox settings
function Install-Firefox {
    Show-Header
    Write-Host "Downloading configuration file, please wait..."
    New-Item -ItemType Directory -Force -Path "$env:ProgramFiles\Mozilla Firefox\distribution" > $null
    try {
        Invoke-WebRequest $FirefoxSettings -OutFile "$env:ProgramFiles\Mozilla Firefox\distribution\policies.json"
    }
    catch {
        Write-Host "Download failed!"
    }
    Read-Host -Prompt "Updated Firefox settings. Press Enter/Return to continue" | Out-Null
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