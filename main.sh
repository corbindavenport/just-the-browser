#!/bin/bash

OS=$(uname)
BASEURL="https://raw.githubusercontent.com/corbindavenport/just-the-browser/main"
MICROSOFT_EDGE_MAC_CONFIG="$BASEURL/edge/edge.mobileconfig"
GOOGLE_CHROME_MAC_CONFIG="$BASEURL/chrome/chrome.mobileconfig"
FIREFOX_MAC_CONFIG="$BASEURL/firefox/firefox.mobileconfig"
FIREFOX_SETTINGS="$BASEURL/firefox/policies.json"
CHROME_SETTINGS="$BASEURL/chrome/managed_policies.json"

# Generate a temporary directory on macOS instead of broken default $TMPDIR
if [ "$OS" = "Darwin" ]; then
    TMPDIR=`mktemp -d`
fi

# Get command to run as root
SUDO=$(which sudo)
DOAS=$(which doas)
if [[ -f "${SUDO}" && -x "${SUDO}" ]]; then
    AS_ROOT="${SUDO}"
elif [[ -f "${DOAS}" && -x "${DOAS}" ]]; then
    AS_ROOT="${DOAS}"
else
    echo "No option to run as root, your system does not have sudo or doas installed."
    exit 1
fi

# Confirm that root access is available
_confirm_root() {
    if [ "$EUID" != 0 ]; then
        echo "Root access is required for this step."
        "${AS_ROOT}" echo "Root access granted." || { echo "Exiting."; exit 1; }
    fi
}

# Remove Firefox JSON file on macOS if it exists, so it does not conflict with the .mobileconfig file
# Previous versions of Just the Browser used the JSON method
_legacy_cleanup() {
    if [ "$OS" = "Darwin" ] && [ -e "/Applications/Firefox.app/Contents/Resources/distribution/policies.json" ]; then
        echo "Previous Firefox policies.json file found, deleting..."
        _confirm_root
        "${AS_ROOT}" rm "/Applications/Firefox.app/Contents/Resources/distribution/policies.json" || { read -p "Remove failed! Press Enter/Return to continue."; return; }
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
        read -p "Press Enter/Return to continue."
    else
        _confirm_root
        "${AS_ROOT}" mkdir -p "/etc/opt/chrome/policies/managed"
        "${AS_ROOT}" curl -Lfs -o "/etc/opt/chrome/policies/managed/managed_policies.json" "$CHROME_SETTINGS" || { read -p "Download failed! Press Enter/Return to continue."; return; }
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
        _confirm_root
        "${AS_ROOT}" rm "/etc/opt/chrome/policies/managed/managed_policies.json" || { read -p "Remove failed! Press Enter/Return to continue."; return; }
        read -p "Removed Chrome settings. Press Enter/Return to continue."
    fi
}

# Install Chromium settings
_install_chromium() {
    _show_header
    echo "Downloading configuration, please wait..."
    _confirm_root
    "${AS_ROOT}" mkdir -p "/etc/chromium/policies/managed"
    "${AS_ROOT}" curl -Lfs -o "/etc/chromium/policies/managed/managed_policies.json" "$CHROME_SETTINGS" || { read -p "Download failed! Press Enter/Return to continue."; return; }
    read -p "Installed Chromium settings. Press Enter/Return to continue."
}

# Remove Google Chrome settings
_uninstall_chromium() {
    _show_header
    _confirm_root
    "${AS_ROOT}" rm "/etc/chromium/policies/managed/managed_policies.json" || { read -p "Remove failed! Press Enter/Return to continue."; return; }
    read -p "Removed Chromium settings. Press Enter/Return to continue."
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
    _legacy_cleanup
    echo "Downloading configuration, please wait..."
    if [ "$OS" = "Darwin" ]; then
        # Download and open configuration file
        curl -Lfs -o "$TMPDIR/firefox.mobileconfig" "$FIREFOX_MAC_CONFIG" || { read -p "Download failed! Press Enter/Return to continue."; return; }
        open "$TMPDIR/firefox.mobileconfig"
        open -b "com.apple.systempreferences"
        # Prompt user to accept file
        echo -e "\nIn the System Settings application, navigate to General > Device Management, then open 'Mozilla Firefox settings' and click the Install button.\n\nIn older macOS versions with System Preferences, this is in the Profiles section.\n"
        read -p "Press Enter/Return to continue."
    else
        _confirm_root
        "${AS_ROOT}" mkdir -p "/etc/firefox/policies/"
        "${AS_ROOT}" curl -Lfs -o "/etc/firefox/policies/policies.json" "$FIREFOX_SETTINGS" || { read -p "Download failed! Press Enter/Return to continue."; return; }
        read -p "Updated Firefox settings. Press Enter/Return to continue."
    fi
}

# Remove Firefox settings
_uninstall_firefox() {
    _show_header
    _legacy_cleanup
    if [ "$OS" = "Darwin" ]; then
        open -b "com.apple.systempreferences"
        echo -e "\nIn the System Settings application, navigate to General > Device Management, then select 'Mozilla Firefox settings' and click the remove (-) button.\n\nIn older macOS versions with System Preferences, this is in the Profiles section.\n"
        read -p "Press Enter/Return to continue."
    else
         _confirm_root
        "${AS_ROOT}" rm "/etc/firefox/policies/policies.json" || { read -p "Remove failed! Press Enter/Return to continue."; return; }
        read -p "Removed Firefox settings. Press Enter/Return to continue.";
    fi
}

# Main menu selection
_main() {
    # Create list for menu options
    declare -a options=()
    # Google Chrome without settings applied
    if [ "$OS" = "Darwin" ]; then
        options+=("Google Chrome: Update settings")
    elif [ "$OS" = "Linux" ] && [ -x "$(command -v google-chrome)" ]; then
        options+=("Google Chrome: Update settings")
    fi
    # Google Chrome with settings already applied
    if [ "$OS" = "Darwin" ]; then
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
    if [ "$OS" = "Darwin" ]; then
        options+=("Microsoft Edge: Update settings")
        options+=("Microsoft Edge: Remove settings")
    fi
    # Firefox without settings applied
    if [ "$OS" = "Darwin" ]; then
        options+=("Mozilla Firefox: Update settings")
    elif [ "$OS" = "Linux" ] && [ -x "$(command -v firefox)" ]; then
        options+=("Mozilla Firefox: Update settings")
    fi
    # Firefox with settings already applied
    if [ "$OS" = "Darwin" ]; then
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
