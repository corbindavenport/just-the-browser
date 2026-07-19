---
layout: layout.njk
title: Brave Browser configuration
permalink: "brave/index.html"
---

Brave Browser features can be configured with group policies. This project uses Windows Registry settings on Windows, and a Profile Manager file on macOS.

You can check which policies are applied in Brave Browser by navigating to the `brave://policy/` page.

### Windows installation

1. Open the [registry file for installation](https://raw.githubusercontent.com/corbindavenport/just-the-browser/main/brave/install.reg) and save it (`Ctrl+S`) anywhere on your computer.
2. In the File Explorer, right-click the file and select Open with > Registry Editor.
3. Follow the prompts to install the registry keys to the Windows Registry.
5. Restart Brave.

To remove the custom configuration, follow the same steps with the [registry file for uninstallation](https://raw.githubusercontent.com/corbindavenport/just-the-browser/main/brave/uninstall.reg). This will remove the modified registry keys from your system.

### macOS installation

1. Open the [configuration file](https://raw.githubusercontent.com/corbindavenport/just-the-browser/main/brave/brave.mobileconfig) and save it (`Command+S`) anywhere on your computer.
2. In the Finder, open the configuration file you downloaded. You should see a prompt that the profile is ready for review.
3. Open the System Settings application (Apple menu > System Settings) and navigate to General > Device Management. If you are on macOS 12 Monterey or an older version, the application is called System Preferences, and you need to open the Profiles section.
4. Double-click on the 'Brave Browser settings' configuration, then click the Install button and follow the prompts.

To remove the custom configuration, open the Device Management settings (or Profiles pane) again, select the 'Brave Browser settings' configuration, and then click the remove (-) button.

### Browser settings

These are the policy settings in the Just the Browser configuration file.

| Feature | Information |
| ------- | ----------- |
| GenAILocalFoundationalModelSettings | Prevents the local AI model from being downloaded. |
| BuiltInDnsClientEnabled | Forces Brave to use the host operating system's DNS client instead of the built-in DNS client. This has no effect when using DNS-over-HTTPS. |
| DefaultBrowserSettingEnabled | Prevents Brave from checking if it's the default browser and showing notifications about it. |
| DevToolsGenAiSettings | Turns off debugging in the Dev Tools powered by generative AI models. |
| BraveWalletDisabled | Disables Wallet, web3, and decentralized DNS settings and functionality. |
| BraveAIChatEnabled | Turns off the AI chat features. |
| BraveNewsDisabled | Turns off suggested news articles from Brave. |
| BraveP3AEnabled | Controls whether the browser sends anonymous usage data to Brave. |
| BraveRewardsDisabled | Turns off the Brave Rewards program where users earn BAT tokens. |
| BraveStatsPingEnabled | A lightweight signal used to count active daily/monthly users. Disabling this stops the browser from announcing its presence to Brave's update servers. |
| BraveTalkDisabled | Disables prompts for [Brave Talk](https://support.brave.app/hc/en-us/articles/4409911973261-How-do-I-use-Brave-Talk) service. It can still be accessed from `talk.brave.com`. |
| BraveWebDiscoveryEnabled | Prevents sending "some anonymous data about searches and web page visits made within the Brave Browser" [for Brave Search](https://support.brave.app/hc/en-us/articles/4409406835469-What-is-the-Web-Discovery-Project). |

### Documentation

- [Brave Group policy list](https://support.brave.app/hc/en-us/articles/360039248271-Group-Policy)
- [Chrome Enterprise policy list](https://chromeenterprise.google/policies/)
- [Chromium Documentation for Administrators](https://www.chromium.org/administrators/linux-quick-start/)