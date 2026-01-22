---
layout: layout.njk
title: Just the Browser
permalink: "index.html"
---

Just the Browser helps you remove AI features, telemetry data reporting, sponsored content, product integrations, and other annoyances from desktop web browsers. The goal is to give you "just the browser" and nothing else, using hidden settings in web browsers intended for companies and other organizations.

This project includes configuration files for popular web browsers, documentation for installing and modifying them, and easy installation scripts. Everything is [open-source on GitHub](https://github.com/corbindavenport/just-the-browser).

<img alt="Just the Browser script on Windows and Mac" src="media/screen.png" />

## Get started

The setup script can install the configuration files in a few clicks. You can also follow the manual guides for [Google Chrome](/chrome), [Microsoft Edge](/edge), and [Firefox](/firefox). Try the guides if the script does not work.

**Windows:** Open a PowerShell prompt as Administrator. You can do this by right-clicking the Windows button in the taskbar, then selecting the "Terminal (Admin)" or "PowerShell (Admin)" menu option. Next, copy the below command, paste it into the window (`Ctrl+V`), and press the Enter/Return key:
```
& ([scriptblock]::Create((irm "https://raw.githubusercontent.com/corbindavenport/just-the-browser/main/main.ps1")))
```

**Mac and Linux:** Search for the Terminal in your applications list and open it. Next, copy the below command, paste it into the window (`Ctrl+V` or `Cmd+V`), and press the Enter/Return key:

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/corbindavenport/just-the-browser/main/main.sh)"
```

## Subscribe to updates

You can subscribe to the RSS/Atom releases feed to know when there are important changes to the configuration files, documentation, and scripts:

```
https://github.com/corbindavenport/just-the-browser/releases.atom
```

This feed can be used with [Feedly](https://feedly.com/i/subscription/feed%2Fhttps%3A%2F%2Fgithub.com%2Fcorbindavenport%2Fjust-the-browser%2Freleases.atom), [Inoreader](https://www.inoreader.com/?add_feed=https://github.com/corbindavenport/just-the-browser/releases.atom), [The Old Reader](https://theoldreader.com/feeds/subscribe?url=https://github.com/corbindavenport/just-the-browser/releases.atom), [Feedbin](https://feedbin.me/?subscribe=https://github.com/corbindavenport/just-the-browser/releases.atom), or any other reader tool. You can also subscribe to new releases with your GitHub account by clicking the Watch button on [the repository](https://github.com/corbindavenport/just-the-browser), then selecting Custom > New releases.

## Download web browsers

Start here if you don't have your preferred web browser installed. You can install the configuration files afterwards.

### Google Chrome

[macOS (Universal)](https://dl.google.com/dl/chrome/mac/universal/stable/gcea/googlechrome.dmg)
[Windows 64-bit x86 (amd64)](https://dl.google.com/chrome/install/googlechromestandaloneenterprise64.msi)
[Windows 32-bit x86](https://dl.google.com/chrome/install/googlechromestandaloneenterprise.msi)
[Windows 64-bit ARM (ARM64)](https://dl.google.com/chrome/install/GoogleChromeStandaloneEnterprise_Arm64.msi)
[Debian/Ubuntu 64-bit x86 (amd64)](https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb)
[Fedora/openSUSE 64-bit x86 (amd64)](https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm)

Not sure which link to use? Try the [official download page](https://www.google.com/chrome/).

### Mozilla Firefox

[macOS (Universal)](https://download.mozilla.org/?product=firefox-latest-ssl&os=osx)
[Windows 64-bit x86 (amd64)](https://download.mozilla.org/?product=firefox-msi-latest-ssl&os=win64)
[Windows 32-bit x86](https://download.mozilla.org/?product=firefox-msi-latest-ssl&os=win)
[Windows 64-bit ARM (ARM64)](https://download.mozilla.org/?product=firefox-latest-ssl&os=win64-aarch64)

Not sure which link to use? Try the [official download page](https://www.firefox.com/en-US/download/) or [Linux setup instructions](https://support.mozilla.org/en-US/kb/install-firefox-linux).

### Microsoft Edge

[macOS (Universal)](https://go.microsoft.com/fwlink/?linkid=2192091)
[Windows 64-bit x86 (amd64)](https://msedge.sf.dl.delivery.mp.microsoft.com/filestreamingservice/files/f14840f4-b905-4a62-8b20-b7a2f24512db/MicrosoftEdgeEnterpriseX64.msi)
[Windows 32-bit x86](https://msedge.sf.dl.delivery.mp.microsoft.com/filestreamingservice/files/6245528d-afd8-4dc0-901b-25b21c16b418/MicrosoftEdgeEnterpriseX86.msi)
[Windows 64-bit ARM (ARM64)](https://msedge.sf.dl.delivery.mp.microsoft.com/filestreamingservice/files/69576d62-e76d-46d8-aa3a-35aca0a545c3/MicrosoftEdgeEnterpriseARM64.msi)

Not sure which link to use? Try the [official download page](https://www.microsoft.com/en-us/edge/download).

## Questions and answers

Got a question? Check here first, and if you still need help, [create an issue on GitHub](https://github.com/corbindavenport/just-the-browser/issues) or [join the Discord](https://discord.com/invite/tqJDRsmQVn).

### What features or settings are changed?

Just the Browser aims to remove the following functionality from popular web browsers:

- **Most AI features**: Features that use generative AI models, either on-device or in the cloud, like Copilot in Microsoft Edge or tab group suggestions in Firefox. The main exception is [page translation in Firefox](https://support.mozilla.org/en-US/kb/website-translation). 
- **Shopping features:** Price tracking, coupon codes, [loan integrations](https://www.windowscentral.com/edge-integrating-buy-now-pay-later-predatory-and-disappointing), etc.
- **Sponsored or third-party content:** Suggested articles on the New Tab Page, sponsored site suggestions, etc.
- **Default browser reminders:** Pop-ups or other prompts that ask you to change the default web browser.
- **First-run experiences and data import prompts:** Browser welcome screens and their related prompts to import data automatically from other web browsers.
- **Telemetry:** Data collection by web browsers. Crash reporting is left enabled if the browser (such as Firefox) supports it as a separate option.
- **Startup boost:** Features that allow web browsers to start with the operating system without explicit permission.

The exact list of features modified for each browser can be found on the pages for [Google Chrome](/chrome), [Microsoft Edge](/edge), and [Firefox](/firefox).

### Can I change or remove the settings?

Yes. The browser guides include steps for removing the configurations, and the automated script can also do it. The browser guides explain each setting, so you can add, remove, or modify the files before you install them.

### Which web browsers are supported?

Just the Browser has configuration files and setup scripts for Google Chrome, Microsoft Edge, and Mozilla Firefox. Chromium builds on Linux are also supported. [Edge on Linux](https://github.com/corbindavenport/just-the-browser/issues/1) is not currently supported.

### Does this also remove AI features from Google Search and other websites?

No. These changes only affect the browser software. You can try using the [&udm=14 workaround](https://udm14.com/) for Google Search.

### Can I install this on my phone or tablet?

Not yet. See the issues for [Android support](https://github.com/corbindavenport/just-the-browser/issues/4) and [iOS/iPadOS support](https://github.com/corbindavenport/just-the-browser/issues/5).

### Is this modifying the web browser?

No. Just the Browser uses [group policies](https://en.wikipedia.org/wiki/Group_Policy) that are fully supported by web browsers, usually intended for IT departments in companies or other large organizations. No applications or executable files are modified in any way.

### Do the settings stay applied?

Yes, as long as the web browsers continue to support the settings used in the configuration files. Web browsers occasionally add, remove, or replace the settings options, so if the custom configuration breaks, try installing the latest available version.

### Does this install ad blockers for me?

No. If you want one, try [uBlock Origin](https://github.com/gorhill/uBlock) or [uBlock Origin Lite](https://github.com/uBlockOrigin/uBOL-home).

### Why does my browser say it's managed by an organization?

The group policy settings used by Just the Browser are intended for PCs managed by companies and other large organizations. Browsers like Microsoft Edge and Firefox will display a message like "Your browser is being managed by your organization" to explain why some settings are disabled.

### How do I know the settings are applied?

You can open `about:policies` in Firefox or `chrome://policy` in Chrome and Edge to see a list of active group policy settings.

### Why not just use an alternative web browser?

You can do that! However, switching to alternative web browsers like Vivaldi, SeaMonkey, Waterfox, or LibreWolf can have other downsides. They are not always available on the same platforms, and they can lag behind mainstream browsers in security updates and engine upgrades. Just the Browser aims to make mainstream web browsers more tolerable, while still retaining their existing benefits.