```
This website and script is still in early development!
```

# Just the Browser

Just the Browser helps you remove telemetry data reporting, AI features, product integrations, and sponsored content from desktop web browsers. The goal is to give you "just the browser" with a more streamlined experience, without resorting to alternative web browsers.

This project includes configuration files for popular web browsers, and a script to install them for you. The [GitHub repository](https://github.com/corbindavenport/just-the-browser) includes the code, resources for contributing, and the configuration files.

![Screenshot of Firefox settings installation on Mac](screen.png)

## Get started

The setup script can do everything for you in a few clicks. You can also follow the manual guides for [Firefox](firefox/README.md).

**Mac and Linux:** open the Terminal application and run the below command:

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/corbindavenport/just-the-browser/HEAD/main.sh)"
```

Windows: Not yet supported!

## Download web browsers

Start here if you don't have your preferred web browser installed.

### Google Chrome

- [macOS (Universal)](https://dl.google.com/dl/chrome/mac/universal/stable/gcea/googlechrome.dmg)
- [Windows 64-bit x86 (amd64)](https://dl.google.com/chrome/install/googlechromestandaloneenterprise64.msi)
- [Windows 32-bit x86](https://dl.google.com/chrome/install/googlechromestandaloneenterprise.msi)
- [Windows 64-bit ARM (ARM64)](https://dl.google.com/chrome/install/GoogleChromeStandaloneEnterprise_Arm64.msi)

Not sure which link to use? Try the [official download page](https://www.google.com/chrome/).

### Mozilla Firefox
- [macOS (Universal)](https://download.mozilla.org/?product=firefox-latest-ssl&os=osx)
- [Windows 64-bit x86 (amd64)](https://download.mozilla.org/?product=firefox-msi-latest-ssl&os=win64)
- [Windows 32-bit x86](https://download.mozilla.org/?product=firefox-msi-latest-ssl&os=win)
- [Windows 64-bit ARM (ARM64)](https://download.mozilla.org/?product=firefox-latest-ssl&os=win64-aarch64)

Not sure which link to use? Try the [official download page](https://www.firefox.com/en-US/download/).

### Microsoft Edge

- [macOS (Universal)](https://go.microsoft.com/fwlink/?linkid=2192091)
- [Windows 64-bit x86 (amd64)](https://msedge.sf.dl.delivery.mp.microsoft.com/filestreamingservice/files/f14840f4-b905-4a62-8b20-b7a2f24512db/MicrosoftEdgeEnterpriseX64.msi)
- [Windows 32-bit x86](https://msedge.sf.dl.delivery.mp.microsoft.com/filestreamingservice/files/6245528d-afd8-4dc0-901b-25b21c16b418/MicrosoftEdgeEnterpriseX86.msi)
- [Windows 64-bit ARM (ARM64)](https://msedge.sf.dl.delivery.mp.microsoft.com/filestreamingservice/files/69576d62-e76d-46d8-aa3a-35aca0a545c3/MicrosoftEdgeEnterpriseARM64.msi)

Not sure which link to use? Try the [official download page](https://www.microsoft.com/en-us/edge/download).

# Questions and answers

Got a question? Check here first.

### Why does this project exist?

Most web browsers now include brand integrations, shopping features, generative AI models that cause [performance problems or decreased battery life](https://www.neowin.net/news/mozilla-under-fire-for-firefox-ai-bloat-that-blows-up-cpu-and-drains-battery/), sponsored content, and other distractions from the core browsing experience. Just the Browser helps you disable these features and get "just the browser," with detailed guides and an automated setup script.

### What features or settings are changed?

Just the Browser aims to remove the following functionality from popular web browsers:

- **Most AI features**: Features that use generative AI models, either on-device or in the cloud, like Copilot in Microsoft Edge or tab group suggestions in Firefox. The main exception is [page translation in Firefox](https://support.mozilla.org/en-US/kb/website-translation). 
- **Shopping features:** Price tracking, coupon codes, [loan integrations](https://www.windowscentral.com/edge-integrating-buy-now-pay-later-predatory-and-disappointing), etc.
- **Sponsored or third-party content:** Suggested articles on the New Tab Page, sponsored site suggestions, etc.
- **Default browser reminders:** Pop-ups or other prompts that ask you to change the default web browser.
- **Telemetry:** Data collection by web browsers. This data is [usually anonymized](https://firefox-source-docs.mozilla.org/toolkit/components/telemetry/index.html) and not a privacy risk, but Just the Browser turns it off regardless.

Some web browsers have additional features that could be considered "bloatware," but the default settings for Just the Browser sticks to those categories.

### Can I change or revert the changes later?

Yes. The browser guides include steps for removing the changes or modifying them. The automated script can also remove the settings.

### Is this modifying the web browser?

No. Just the Browser uses [group policies](https://en.wikipedia.org/wiki/Group_Policy) that are fully supported by web browsers, usually intended for IT departments in companies or other large organizations. No applications or executable files are modified in any way.

### Do the settings stay applied?

The custom settings stay applied as long as the policy features remain supported, but web browsers occasionally add, remove, or replace their policy options. You can check the browser guides or run the setup script again to get the latest configurations.

### Why does my browser now say it's managed by an organization?

The group policy settings used by Just the Browser are intended for PCs managed by companies and other large organizations. Browsers like Microsoft Edge and Firefox will display a message like "Your browser is being managed by your organization" to explain why some settings are disabled.

### Why not just use an alternative web browser?

You can do that! However, switching to alternative web browsers like Vivaldi, SeaMonkey, Waterfox, or LibreWolf can have other downsides. They are not always available on the same platforms, and they can lag behind mainstream browsers in security updates and engine upgrades. Just the Browser aims to make mainstream web browsers more tolerable, while still retaining their existing benefits.