#!/bin/bash

OS=$(uname)
BASEURL="https://raw.githubusercontent.com/corbindavenport/just-the-browser/main"
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
        curl -Lfs -o "$TMPDIR/chrome.mobileconfig" "$GOOGLE_CHROME_MAC_CONFIG" || { read -p "Download failed! Press Enter/Return to continue."; return; }
        open "$TMPDIR/chrome.mobileconfig"
        open -b "com.apple.systempreferences"
        # Prompt user to accept file
        echo -e "\nIn the System Settings application, navigate to General > Device Management, then open Google Chrome settings and click the Install button.\n\nIn older macOS versions with System Preferences, this is in the Profiles section.\n"
    else
        _confirm_sudo
        sudo mkdir -p "/etc/opt/chrome/policies/managed"
        sudo curl -Lfs -o "/etc/opt/chrome/policies/managed/managed_policies.json" "$CHROME_SETTINGS" || { read -p "Download failed! Press Enter/Return to continue."; return; }
    fi
    read -p "Enter/Return to continue."
}

# Remove Google Chrome settings
_uninstall_chrome() {
    _show_header
    if [ "$OS" = "Darwin" ]; then
        open -b "com.apple.systempreferences"
        echo -e "\nIn the System Settings application, navigate to General > Device Management, then select 'Google Chrome settings' and click the remove (-) button.\n\nIn older macOS versions with System Preferences, this is in the Profiles section.\n"
    else
        _confirm_sudo
        sudo rm "/etc/opt/chrome/policies/managed/managed_policies.json" || { read -p "Remove failed! Press Enter/Return to continue."; return; }
    fi
    read -p "Enter/Return to continue."
}

# Install Microsoft Edge settings
_install_edge() {
    _show_header
    echo "Downloading configuration, please wait..."
    # Download and open configuration file
    curl -Lfs -o "$TMPDIR/edge.mobileconfig" "$MICROSOFT_EDGE_MAC_CONFIG" || { read -p "Download failed! Press Enter/Return to continue."; return; }
    open "$TMPDIR/edge.mobileconfig"
    open -b "com.apple.systempreferences"
    # Prompt user to accept file
    echo -e "\nIn the System Settings application, navigate to General > Device Management, then open Microsoft Edge settings and click the Install button.\n\nIn older macOS versions with System Preferences, this is in the Profiles section.\n"
    read -p "Enter/Return to continue."
}

# Remove Microsoft Edge settings
_uninstall_edge() {
    _show_header
    open -b "com.apple.systempreferences"
    echo -e "\nIn the System Settings application, navigate to General > Device Management, then select 'Microsoft Edge settings' and click the remove (-) button.\n\nIn older macOS versions with System Preferences, this is in the Profiles section.\n"
    read -p "Enter/Return to continue."
}

# Install Firefox settings
_install_firefox() {
    _show_header
    echo "Downloading configuration, please wait..."
    if [ "$OS" = "Darwin" ]; then
        mkdir -p "/Applications/Firefox.app/Contents/Resources/distribution/"
        curl -Lfs -o "/Applications/Firefox.app/Contents/Resources/distribution/policies.json" "$FIREFOX_SETTINGS" || { read -p "Download failed! Press Enter/Return to continue."; return; }
    else
        _confirm_sudo
        sudo mkdir -p "/etc/firefox/policies/"
        sudo curl -Lfs -o "/etc/firefox/policies/policies.json" "$FIREFOX_SETTINGS" || { read -p "Download failed! Press Enter/Return to continue."; return; }
    fi
    read -p "Updated Firefox settings. Press Enter/Return to continue."
}

# Remove Firefox settings
_uninstall_firefox() {
    _show_header
    if [ "$OS" = "Darwin" ]; then
        rm "/Applications/Firefox.app/Contents/Resources/distribution/policies.json" || { read -p "Remove failed! Press Enter/Return to continue"; return; }
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
    # Google Chrome
    if [ "$OS" = "Darwin" ] && [ -e "/Applications/Google Chrome.app" ]; then
        options+=("Google Chrome: Update settings")
        options+=("Google Chrome: Remove settings")
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
