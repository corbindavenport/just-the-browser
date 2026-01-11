# Microsoft Edge configuration

Microsoft Edge features can be configured with group policies. This project uses Windows Registry settings on Windows.

You can check which policies are applied in Microsoft Edge by navigating to the `edge://policy/` page.

### Windows installation

1. Open the [registry file for installation](https://raw.githubusercontent.com/corbindavenport/just-the-browser/main/edge/install.reg) and save it (`Ctrl+S`) anywhere on your computer.
2. In the File Explorer, right-click the file and select Open with > Registry Editor.
3. Follow the prompts to install the registry keys to the Windows Registry.
5. Restart Edge.

To remove the custom configuration, follow the same steps with the [registry file for uninstallation](https://raw.githubusercontent.com/corbindavenport/just-the-browser/main/edge/uninstall.reg). This will remove the modified registry keys from your system.

### macOS installation

TODO

### Linux installation

TODO

### Browser settings

These are the policy settings in the Just the Browser configuration file. 

| Feature | Information |
| ------- | ----------- |
| `HideFirstRunExperience` | The First-run experience and the splash screen will not be shown to users when they run Microsoft Edge for the first time. |

### Documentation

- [Microsoft Edge policy documentation and full list](https://learn.microsoft.com/en-us/DeployEdge/microsoft-edge-policies)