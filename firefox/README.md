---
layout: layout.njk
title: Mozilla Firefox configuration
permalink: "firefox/index.html"
---

Firefox features can be configured using Group Policy templates on Windows, Intune on Windows, configuration profiles on macOS, or with a custom `policies.json` file. This project uses the JSON file method on Linux, Windows Registry settings on Windows, and a Profile Manager file on macOS.

You can check which policies are applied in Firefox by navigating to the `about:policies` page.

### Windows installation

1. Open the [registry file for installation](https://raw.githubusercontent.com/corbindavenport/just-the-browser/main/firefox/install.reg) and save it (`Ctrl+S`) anywhere on your computer.
2. In the File Explorer, right-click the file and select Open with > Registry Editor.
3. Follow the prompts to install the registry keys to the Windows Registry.
5. Restart Firefox.

To remove the custom configuration, follow the same steps with the [registry file for uninstallation](https://raw.githubusercontent.com/corbindavenport/just-the-browser/main/firefox/uninstall.reg). This will remove the modified registry keys from your system.

If the custom settings are still active, you may have used the JSON file method for installation. Find your Firefox installation directory, such as `C:\Program Files\Mozilla Firefox`, and check if it contains a "distribution" directory. If there is a `policies.json` file in the distribution directory, delete it.

### macOS installation

The macOS configuration file applies to all versions of Firefox. This includes Firefox stable, Firefox ESR, Firefox Beta, Firefox Developer Edition, and Firefox Nightly.

1. Open the [configuration file](https://raw.githubusercontent.com/corbindavenport/just-the-browser/main/firefox/firefox.mobileconfig) and save it (`Command+S`) anywhere on your computer.
2. In the Finder, open the configuration file you downloaded. You should see a prompt that the profile is ready for review.
3. Open the System Settings application (Apple menu > System Settings) and navigate to General > Device Management. If you are on macOS 12 Monterey or an older version, the application is called System Preferences, and you need to open the Profiles section.
4. Double-click on the 'Mozilla Firefox settings' configuration, then click the Install button and follow the prompts.

To remove the custom configuration, open the Device Management settings (or Profiles pane) again, select the 'Mozilla Firefox settings' configuration, and then click the remove (-) button.

If there is no Firefox item in the Device Management settings, you may have the older JSON file installed. You can delete the JSON file by opening your Terminal app (`Command+Spacebar` and type "terminal") and pasting this command:

```bash
sudo rm "/Applications/Firefox.app/Contents/Resources/distribution/policies.json"
```

That command will delete the JSON configuration file used by previous versions of Just The Browser, if the file exists.

### Linux installation

1. Open the [configuration file](https://raw.githubusercontent.com/corbindavenport/just-the-browser/main/firefox/policies.json) and save it (`Ctrl+S`) anywhere on your computer. Make sure the file is called "policies.json" (without the quotes).
2. Open a new Terminal window in the directory where the file is located. For example, if it's in your Downloads folder, open a Terminal and run `cd ~/Downloads` to switch to the Downloads directory.
3. Create the Firefox policies directory with this command: `sudo mkdir -p /etc/firefox/policies/`
4. Copy the file to the new folder: `sudo cp ./policies.json /etc/firefox/policies/`
5. Restart Firefox.

To remove the custom configuration, delete the `policies.json` file from the distribution folder and restart Firefox. You can do that in the Terminal: `sudo rm /etc/firefox/policies/policies.json`

### Browser settings

These are the policy settings in the Just the Browser configuration file.

| Feature | Information |
| ------- | ----------- |
| `DisableFirefoxStudies` | Prevents Firefox from enrolling in [Studies](https://support.mozilla.org/en-US/kb/shield), which may involve additional analytics reporting. |
| `DisableTelemetry` | Prevents the upload of telemetry data. As of Firefox 83 and Firefox ESR 78.5, local storage of telemetry data is disabled as well. |
| `DontCheckDefaultBrowser` | Prevents popup warnings about Firefox not being the default browser. |
| `FirefoxHome` | Turns off stores, sponsored stories, and sponsored top sites on the Firefox Home page. |
| `GenerativeAI` | Turns off generative AI features, including AI chatbots in the sidebar, link previews, and tab group suggestions. |
| `AIControls` | Turns off most AI controls, including SmartTabGroups, LinkPreviewKeyPoints, SidebarChatbot, and the SmartWindow. PDFAltText and Translations are left enabled, but they can be turned off from `about:preferences#ai` if desired. |
| `SearchEngines` | Removes Perplexity AI as a default search engine. |

### Documentation

- [Customize Firefox using policies.json](https://support.mozilla.org/en-US/kb/customizing-firefox-using-policiesjson)
- [Firefox policies list](https://mozilla.github.io/policy-templates/)
