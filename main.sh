#!/bin/bash

OS=$(uname)
BASEURL="https://raw.githubusercontent.com/corbindavenport/just-the-browser/HEAD/"
FIREFOX_SETTINGS="$BASEURL/settings/firefox.json"

# Install Firefox settings
_install_firefox() {
    mkdir -p "/Applications/Firefox.app/Contents/Resources/distribution/"
    curl -Lfs --progress-bar -o "/Applications/Firefox.app/Contents/Resources/distribution/policies.json" "$FIREFOX_SETTINGS" || { echo "Failed!"; return; }
    echo "Done!"
}

# Remove Firefox settings
_uninstall_firefox() {
    rm "/Applications/Firefox.app/Contents/Resources/distribution/policies.json" || { echo "Failed!"; return; }
    echo "Done!"
}

# Main menu selection
_main() {
    # Create list for menu options
    declare -a options=()
    # Check Firefox options
    if [ "$OS" = "Darwin" ] && [ -e "/Applications/Firefox.app/Contents/Resources/distribution/policies.json" ]; then
        options+=("Mozilla Firefox: Remove settings")
    elif [ "$OS" = "Darwin" ] && [ -e "/Applications/Firefox.app" ]; then
        options+=("Mozilla Firefox: Add settings")
    fi
    # Add exit option
    options+=("Exit")
    # Show main menu
    echo -e "\nJust the Browser\n================\n\nSelect an option by typing the number, then pressing Return/Enter on your keyboard to confirm.\n\nYou will need to restart your browser for changes to take effect.\n"
    select choice in "${options[@]}"; do
        if [ "$choice" = "Mozilla Firefox: Add settings" ]; then
            _install_firefox
        elif [ "$choice" = "Mozilla Firefox: Remove settings" ]; then
            _uninstall_firefox
        else
            exit 0
        fi
    done
}

_main