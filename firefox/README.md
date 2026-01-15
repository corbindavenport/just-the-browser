---
layout: layout.njk
title: Mozilla Firefox configuration
permalink: "firefox/index.html"
---

Firefox features can be configured using Group Policy templates on Windows, Intune on Windows, configuration profiles on macOS, or with a custom `policies.json` file. This project uses the JSON file method.

You can check which policies are applied in Firefox by navigating to the `about:policies` page.

### Windows installation

1. Open the [configuration file](https://raw.githubusercontent.com/corbindavenport/just-the-browser/main/firefox/policies.json) and save it (`Ctrl+S`) anywhere on your computer.
2. Open the File Explorer and find where the Firefox executable is installed. This should be `C:\Program Files\Mozilla Firefox` on most PCs.
3. In the same directory as Firefox, create a new folder (New menu > Folder) called "distribution" without the quotes, if it does not already exist.
4. Move the configuration file to the distribution folder, and make sure it is called "policies.json" (without the quotes).
5. Restart Firefox.

To remove the custom configuration, delete the `policies.json` file from the distribution folder and restart Firefox.

### macOS installation

**Note:** You need to open Firefox at least one time before adding a configuration file, or macOS will identify Firefox as a damaged application.

1. Open the [configuration file](https://raw.githubusercontent.com/corbindavenport/just-the-browser/main/firefox/policies.json) and save it (File > Save or `Command+S`) anywhere on your computer.
2. Open your Applications folder and find the Firefox application. If Firefox is in the Dock, you can click it while holding the `Command` key to instantly show it in the Finder.
3. Click on the Firefox app while holding the `Control` key (or right-click) and select 'Show Package Contents'.
4. Go to Contents > Resources and create a new folder (File > New Folder) called "distribution" (without the quotes), if it does not already exist.
5. Move the configuration file to the distribution folder, and make sure it is called "policies.json" (without the quotes).
6. Restart Firefox.

To remove the custom configuration, delete the `policies.json` file from the distribution folder and restart Firefox.

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
| `GenerativeAI` | Turns off all generative AI features, including AI chatbots in the sidebar, link previews, and tab group suggestions. |
| `SearchEngines` | Removes Perplexity AI as a default search engine. |

### Documentation

- [Customize Firefox using policies.json](https://support.mozilla.org/en-US/kb/customizing-firefox-using-policiesjson)
- [Firefox policies list](https://mozilla.github.io/policy-templates/)
