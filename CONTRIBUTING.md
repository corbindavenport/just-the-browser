# Contributing to Just the Browser

Do you want to help improve Just the Browser? Here's what you need to know.

### Setup script

The Windows script is a **PowerShell v5.1** script, so it can run out of the box on Windows 10 and later versions. If you are working on the script, please ensure you are not using PowerShell features or syntax from later versions (e.g. PowerShell 7/PowerShell Core).

The Linux and macOS script is a Bash script. The baseline testing environment is the **Bash v3.2** shell bundled with macOS.

### Configuration changes

If you are contributing updates to the browser configuration settings, your changes should be synchronized across the configuration files for all platforms. For example, if you are adding a setting called `EnableExample` to Microsoft Edge, it should be added to `install.reg` for Windows systems and `edge.mobileconfig` for macOS. The features also need to be listed in the `README.md` files for each browser.