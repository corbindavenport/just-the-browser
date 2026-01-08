#!/bin/bash

OS=$(uname)
BASEURL="https://raw.githubusercontent.com/corbindavenport/just-the-browser/HEAD/"
FIREFOX_SETTINGS="$BASEURL/firefox/policies.json"

# Confirm that sudo access is available
_confirm_sudo() {
    if [ "$EUID" != 0 ]; then
        echo "Sudo access is required for this step."
        sudo echo "Sudo granted." || { echo "Exiting."; exit 1; }
    fi
}

# Install Firefox settings
_install_firefox() {
    echo "Please wait..."
    if [ "$OS" = "Darwin" ]; then
        mkdir -p "/Applications/Firefox.app/Contents/Resources/distribution/"
        curl -Lfs -o "/Applications/Firefox.app/Contents/Resources/distribution/policies.json" "$FIREFOX_SETTINGS" || { echo "Failed!"; return; }
    else
        _confirm_sudo
        sudo mkdir -p "/etc/firefox/policies/"
        sudo curl -Lfs -o "/etc/firefox/policies/policies.json" "$FIREFOX_SETTINGS" || { echo "Failed!"; return; }
    fi
    echo "Done!"
}

# Remove Firefox settings
_uninstall_firefox() {
    if [ "$OS" = "Darwin" ]; then
        rm "/Applications/Firefox.app/Contents/Resources/distribution/policies.json" || { echo "Failed!"; return; }
    else
         _confirm_sudo
        sudo rm "/Applications/Firefox.app/Contents/Resources/distribution/policies.json" || { echo "Failed!"; return; }
    fi
    echo "Done!"
}

# Main menu selection
_main() {
    # Create list for menu options
    declare -a options=()
    # Check Firefox options
    if [ "$OS" = "Darwin" ] && [ -e "/Applications/Firefox.app/Contents/Resources/distribution/policies.json" ]; then
        # Mac with Firefox settings already installed
        options+=("Mozilla Firefox: Remove settings")
    elif [ "$OS" = "Linux" ] && [ -e "/etc/firefox/policies/policies.json" ]; then
        # Linux PC with Firefox settings already installed
        options+=("Mozilla Firefox: Remove settings")
    elif [ "$OS" = "Darwin" ] && [ -e "/Applications/Firefox.app" ]; then
        # Mac without Firefox settings
        options+=("Mozilla Firefox: Add settings")
    elif [ "$OS" = "Linux" ] && [ -x "$(command -v firefox)" ]; then
        # Linux PC without Firefox settings
        options+=("Mozilla Firefox: Add settings")
    fi
    # Add exit option
    options+=("Exit")
    # Show main menu
    echo -e "\nJust the Browser on $OS\n====================\n\nSelect an option by typing the number, then pressing Return/Enter on your keyboard to confirm.\n\nYou will need to restart your browser for changes to take effect.\n"
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