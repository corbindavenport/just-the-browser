---
layout: layout.njk
title: Google Chrome configuration
permalink: "chrome/index.html"
---

Google Chrome features can be configured with group policies. This project uses Windows Registry settings on Windows, and a Profile Manager file on macOS.

You can check which policies are applied in Google Chrome by navigating to the `chrome://policy/` page.

### Windows installation

1. Open the [registry file for installation](https://raw.githubusercontent.com/corbindavenport/just-the-browser/main/chrome/install.reg) and save it (`Ctrl+S`) anywhere on your computer.
2. In the File Explorer, right-click the file and select Open with > Registry Editor.
3. Follow the prompts to install the registry keys to the Windows Registry.
5. Restart Chrome.

To remove the custom configuration, follow the same steps with the [registry file for uninstallation](https://raw.githubusercontent.com/corbindavenport/just-the-browser/main/chrome/uninstall.reg). This will remove the modified registry keys from your system.

### macOS installation

1. Open the [configuration file](https://raw.githubusercontent.com/corbindavenport/just-the-browser/main/chrome/chrome.mobileconfig) and save it (`Command+S`) anywhere on your computer.
2. In the Finder, open the configuration file you downloaded. You should see a prompt that the profile is ready for review.
3. Open the System Settings application (Apple menu > System Settings) and navigate to General > Device Management. If you are on macOS 12 Monterey or an older version, the application is called System Preferences, and you need to open the Profiles section.
4. Double-click on the 'Google Chrome settings' configuration, then click the Install button and follow the prompts.

To remove the custom configuration, open the Device Management settings (or Profiles pane) again, select the 'Google Chrome settings' configuration, and then click the remove (-) button.

### Browser settings

These are the policy settings in the Just the Browser configuration file.

| Feature | Information |
| ------- | ----------- |
| AIModeSettings | Turns off Google's AI Mode integrations in the address bar and the New Tab page search box. |
| CreateThemesSettings | Turns off the ability to create custom themes and wallpapers with generative AI. |
| GeminiSettings | Blocks Gemini app integrations. |
| GenAILocalFoundationalModelSettings | Prevents the local AI model from being downloaded. |
| HelpMeWriteSettings | Turns off the Help Me Write feature powered by AI. |
| HistorySearchSettings | Turns off AI History Search. |
| TabCompareSettings | Turns off the AI-powered Tab Compare feature. |
| BuiltInDnsClientEnabled | Forces Chrome to use the host operating system's DNS client instead of the built-in DNS client. This has no effect when using DNS-over-HTTPS. |
| DefaultBrowserSettingEnabled | Prevents Chrome from checking if it's the default browser and showing notifications about it. |

### Documentation

- [Chrome Enterprise policy list](https://chromeenterprise.google/policies/)