# Contributing to Just the Browser

Do you want to help improve Just the Browser? Here's what you need to know.

### Configuration changes

**New configuration settings should be discussed in an issue on GitHub first.** Everyone's definition of bloatware and privacy is different, and Just the Browser aims more for sensible defaults rather than a fully locked-down experience. Pull requests or other requests to turn of Google Safe Browsing, search engine auto-complete suggestions, or other similar functionality will not be considered. 

If you are contributing updates to the browser configuration settings, your changes should be synchronized across the configuration files for all platforms. In the browser's directory (e.g. `chrome` or `firefox`):

1. Add the setting to `install.reg` for Windows systems
2. Add the setting to the `.mobileconfig` file for macOS
3. Add the setting to the `.json` file for Linux (if there is one)
4. Add the setting and an explanation of the change to the README.md file

### Working on the scripts

The Windows script is a **PowerShell v5.0** script, so it can run out of the box on Windows 8.1, Windows 10, and Windows 11.

If you are working on the script, please ensure you are not using PowerShell features or syntax from later versions, such as PowerShell 7/PowerShell Core.

The Linux and macOS script is a Bash script. The baseline testing environment is the **Bash v3.2** shell bundled with macOS.