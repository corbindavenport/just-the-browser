#!/bin/bash

OS=$(uname)
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
USE_LOCAL_FILES=false
if [ -f "$SCRIPT_DIR/chrome/managed_policies.json" ]; then
    BASEURL="$SCRIPT_DIR"
    USE_LOCAL_FILES=true
else
    BASEURL="https://raw.githubusercontent.com/corbindavenport/just-the-browser/main"
fi
MICROSOFT_EDGE_MAC_CONFIG="$BASEURL/edge/edge.mobileconfig"
GOOGLE_CHROME_MAC_CONFIG="$BASEURL/chrome/chrome.mobileconfig"
FIREFOX_SETTINGS="$BASEURL/firefox/policies.json"
CHROME_SETTINGS="$BASEURL/chrome/managed_policies.json"

# Confirm that sudo access is available
_confirm_sudo() {
    if [ "$EUID" != 0 ]; then
        echo "Sudo access is required for this step."
        sudo echo "Sudo granted." || { echo "Exiting."; exit 1; }
    fi
}

# Show a summary of settings per browser
_show_chrome_changes() {
    local header=${1:-"Applied Chrome policy bundle"}
    cat <<EOF

$header:
- Disable AI features and AI-assisted tools
- Disable translation prompts
- Disable password manager and save prompts
- Disable printing
- Restore previous session on startup
- Enable Do Not Track
- Disable default browser prompts and use system DNS
EOF
}

_show_edge_changes() {
    local header=${1:-"Applied Edge policy bundle"}
    cat <<EOF

$header:
- Disable AI features, shopping tools, and recommendations
- Disable translation prompts
- Disable password manager and save prompts
- Disable printing
- Restore previous session on startup
- Enable Do Not Track
- Reduce Microsoft promotions and content surfaces
EOF
}

_show_firefox_changes() {
    local header=${1:-"Applied Firefox policy bundle"}
    cat <<EOF

$header:
- Disable telemetry, studies, and AI features
- Disable translation prompts
- Disable password saving and autofill
- Disable printing
- Restore previous session on startup
- Enable Do Not Track and Global Privacy Control
EOF
}

# Fetch config files locally or remotely
_fetch_file() {
    local source=$1
    local destination=$2
    local requires_sudo=$3

    if [ "$USE_LOCAL_FILES" = true ]; then
        if [ "$requires_sudo" = true ]; then
            sudo cp "$source" "$destination"
        else
            cp "$source" "$destination"
        fi
    else
        if [ "$requires_sudo" = true ]; then
            sudo curl -Lfs -o "$destination" "$source"
        else
            curl -Lfs -o "$destination" "$source"
        fi
    fi
}

# Render initial interface for all pages
_show_header() {
    clear
    echo -e "\nJust the Browser ($OS)\n========\n"
}

# Install Google Chrome settings
_install_chrome() {
    _show_header
    echo "Downloading configuration, please wait..."
    if [ "$OS" = "Darwin" ]; then
        # Download and open configuration file
        _fetch_file "$GOOGLE_CHROME_MAC_CONFIG" "$TMPDIR/chrome.mobileconfig" false || { read -p "Download failed! Press Enter/Return to continue."; return; }
        open "$TMPDIR/chrome.mobileconfig"
        open -b "com.apple.systempreferences"
        # Prompt user to accept file
        echo -e "\nIn the System Settings application, navigate to General > Device Management, then open Google Chrome settings and click the Install button.\n\nIn older macOS versions with System Preferences, this is in the Profiles section."
        _show_chrome_changes "This profile configures"
        read -p "Press Enter/Return to continue."
    else
        _confirm_sudo
        sudo mkdir -p "/etc/opt/chrome/policies/managed"
        _fetch_file "$CHROME_SETTINGS" "/etc/opt/chrome/policies/managed/managed_policies.json" true || { read -p "Download failed! Press Enter/Return to continue."; return; }
        _show_chrome_changes
        read -p "Installed Chrome settings. Press Enter/Return to continue."
    fi
}

# Remove Google Chrome settings
_uninstall_chrome() {
    _show_header
    if [ "$OS" = "Darwin" ]; then
        open -b "com.apple.systempreferences"
        echo -e "\nIn the System Settings application, navigate to General > Device Management, then select 'Google Chrome settings' and click the remove (-) button.\n\nIn older macOS versions with System Preferences, this is in the Profiles section.\n"
        read -p "Press Enter/Return to continue."
    else
        _confirm_sudo
        sudo rm "/etc/opt/chrome/policies/managed/managed_policies.json" || { read -p "Remove failed! Press Enter/Return to continue."; return; }
        read -p "Removed Chrome settings. Press Enter/Return to continue."
    fi
}

# Install Chromium settings
_install_chromium() {
    _show_header
    echo "Downloading configuration, please wait..."
    _confirm_sudo
    sudo mkdir -p "/etc/chromium/policies/managed"
    _fetch_file "$CHROME_SETTINGS" "/etc/chromium/policies/managed/managed_policies.json" true || { read -p "Download failed! Press Enter/Return to continue."; return; }
    _show_chrome_changes "Applied Chromium policy bundle"
    read -p "Installed Chromium settings. Press Enter/Return to continue."
}

# Remove Google Chrome settings
_uninstall_chromium() {
    _show_header
    _confirm_sudo
    sudo rm "/etc/chromium/policies/managed/managed_policies.json" || { read -p "Remove failed! Press Enter/Return to continue."; return; }
    read -p "Removed Chromium settings. Press Enter/Return to continue."
}

# Install Microsoft Edge settings
_install_edge() {
    _show_header
    echo "Downloading configuration, please wait..."
    # Download and open configuration file
    _fetch_file "$MICROSOFT_EDGE_MAC_CONFIG" "$TMPDIR/edge.mobileconfig" false || { read -p "Download failed! Press Enter/Return to continue."; return; }
    open "$TMPDIR/edge.mobileconfig"
    open -b "com.apple.systempreferences"
    # Prompt user to accept file
    echo -e "\nIn the System Settings application, navigate to General > Device Management, then open Microsoft Edge settings and click the Install button.\n\nIn older macOS versions with System Preferences, this is in the Profiles section."
    _show_edge_changes "This profile configures"
    read -p "Press Enter/Return to continue."
}

# Remove Microsoft Edge settings
_uninstall_edge() {
    _show_header
    open -b "com.apple.systempreferences"
    echo -e "\nIn the System Settings application, navigate to General > Device Management, then select 'Microsoft Edge settings' and click the remove (-) button.\n\nIn older macOS versions with System Preferences, this is in the Profiles section.\n"
    read -p "Press Enter/Return to continue."
}

# Install Firefox settings
_install_firefox() {
    _show_header
    echo "Downloading configuration, please wait..."
    if [ "$OS" = "Darwin" ]; then
        _confirm_sudo
        sudo mkdir -p "/Applications/Firefox.app/Contents/Resources/distribution/"
        _fetch_file "$FIREFOX_SETTINGS" "/Applications/Firefox.app/Contents/Resources/distribution/policies.json" true || { read -p "Download failed! Press Enter/Return to continue."; return; }
    else
        _confirm_sudo
        sudo mkdir -p "/etc/firefox/policies/"
        _fetch_file "$FIREFOX_SETTINGS" "/etc/firefox/policies/policies.json" true || { read -p "Download failed! Press Enter/Return to continue."; return; }
    fi
    _show_firefox_changes
    read -p "Updated Firefox settings. Press Enter/Return to continue."
}

# Remove Firefox settings
_uninstall_firefox() {
    _show_header
    if [ "$OS" = "Darwin" ]; then
        _confirm_sudo
        sudo rm "/Applications/Firefox.app/Contents/Resources/distribution/policies.json" || { read -p "Remove failed! Press Enter/Return to continue"; return; }
    else
         _confirm_sudo
        sudo rm "/etc/firefox/policies/policies.json" || { read -p "Remove failed! Press Enter/Return to continue."; return; }
    fi
    read -p "Removed Firefox settings. Press Enter/Return to continue."; return;
}

# Main menu selection
_main() {
    # Create list for menu options
    declare -a options=()
    # Google Chrome without settings applied
    if [ "$OS" = "Darwin" ] && [ -e "/Applications/Google Chrome.app" ]; then
        options+=("Google Chrome: Update settings")
    elif [ "$OS" = "Linux" ] && [ -x "$(command -v google-chrome)" ]; then
        options+=("Google Chrome: Update settings")
    fi
    # Google Chrome with settings already applied
    if [ "$OS" = "Darwin" ] && [ -e "/Applications/Google Chrome.app" ]; then
        options+=("Google Chrome: Remove settings")
    elif [ "$OS" = "Linux" ] && [ -e "/etc/opt/chrome/policies/managed/managed_policies.json" ]; then
        options+=("Google Chrome: Remove settings")
    fi
    # Chromium without settings applied
    if [ "$OS" = "Linux" ] && [ -x "$(command -v chromium-browser)" ]; then
        options+=("Chromium: Update settings")
    fi
    # Chromium with settings already applied
    if [ "$OS" = "Linux" ] && [ -e "/etc/chromium/policies/managed/managed_policies.json" ]; then
        options+=("Chromium: Remove settings")
    fi
    # Microsoft Edge
    if [ "$OS" = "Darwin" ] && [ -e "/Applications/Microsoft Edge.app" ]; then
        options+=("Microsoft Edge: Update settings")
        options+=("Microsoft Edge: Remove settings")
    fi
    # Firefox without settings applied
    if [ "$OS" = "Darwin" ] && [ -e "/Applications/Firefox.app" ]; then
        options+=("Mozilla Firefox: Update settings")
    elif [ "$OS" = "Linux" ] && [ -x "$(command -v firefox)" ]; then
        options+=("Mozilla Firefox: Update settings")
    fi
    # Firefox with settings already applied
    if [ "$OS" = "Darwin" ] && [ -e "/Applications/Firefox.app/Contents/Resources/distribution/policies.json" ]; then
        options+=("Mozilla Firefox: Remove settings")
    elif [ "$OS" = "Linux" ] && [ -e "/etc/firefox/policies/policies.json" ]; then
        options+=("Mozilla Firefox: Remove settings")
    fi
    # Add exit option
    options+=("Exit")
    # Show main menu
    _show_header
    echo -e "Select an option by typing the number, then pressing Return/Enter on your keyboard to confirm.\n\nYou will need to restart your browser for changes to take effect.\n"
    select choice in "${options[@]}"; do
        if [ "$choice" = "Google Chrome: Update settings" ]; then
            _install_chrome
        elif [ "$choice" = "Google Chrome: Remove settings" ]; then
            _uninstall_chrome
        elif [ "$choice" = "Chromium: Update settings" ]; then
            _install_chromium
        elif [ "$choice" = "Chromium: Remove settings" ]; then
            _uninstall_chromium
        elif [ "$choice" = "Microsoft Edge: Update settings" ]; then
            _install_edge
        elif [ "$choice" = "Microsoft Edge: Remove settings" ]; then
            _uninstall_edge
        elif [ "$choice" = "Mozilla Firefox: Update settings" ]; then
            _install_firefox
        elif [ "$choice" = "Mozilla Firefox: Remove settings" ]; then
            _uninstall_firefox
        elif [ "$choice" = "Exit" ]; then
            exit 0
        else
            read -p "Invalid option. Press Enter/Return to continue.";
        fi
    done
}

_main
