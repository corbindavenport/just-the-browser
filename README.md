# Just the Browser

Just the Browser is a tool for removing telemetry data reporting, AI features, product integrations, and sponsored content from desktop web browsers. The goal is to give you "just the browser" with a more streamlined experience, using policy settings intended for corporations and other organizations.

This project is in early development, aiming to support popular web browsers on Windows, Mac, and Linux. You can check out the [GitHub repository](https://github.com/corbindavenport/just-the-browser) to contribute or look at the code.

![Screenshot of Firefox settings installation on Mac](screen.png)

## Get started

On Mac, open the Terminal application and paste this command:

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/corbindavenport/just-the-browser/HEAD/main.sh)"
```

Linux and Windows are not yet supported.

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

- [macOS (Universal)](https://msedge.sf.dl.delivery.mp.microsoft.com/filestreamingservice/files/39c16afe-6ffe-42f8-aa82-4dd057fcf1d5/MicrosoftEdge-143.0.3650.96.pkg)
- [Windows 64-bit x86 (amd64)](https://msedge.sf.dl.delivery.mp.microsoft.com/filestreamingservice/files/f14840f4-b905-4a62-8b20-b7a2f24512db/MicrosoftEdgeEnterpriseX64.msi)
- [Windows 32-bit x86](https://msedge.sf.dl.delivery.mp.microsoft.com/filestreamingservice/files/6245528d-afd8-4dc0-901b-25b21c16b418/MicrosoftEdgeEnterpriseX86.msi)
- [Windows 64-bit ARM (ARM64)](https://msedge.sf.dl.delivery.mp.microsoft.com/filestreamingservice/files/69576d62-e76d-46d8-aa3a-35aca0a545c3/MicrosoftEdgeEnterpriseARM64.msi)

Not sure which link to use? Try the [official download page](https://www.microsoft.com/en-us/edge/download).

## Browser modifications

Just the Browser uses group policy settings to change the behavior of web browsers. Firefox settings are applied with a [policies JSON file](https://mozilla.github.io/policy-templates/), and you can check the status by opening the `about:policies` page.

### Mozilla Firefox

| Feature | Information |
| ------- | ----------- |
| [DisableFirefoxStudies](https://mozilla.github.io/policy-templates/#disablefirefoxstudies) | Prevents Firefox from enrolling in [Studies](https://support.mozilla.org/en-US/kb/shield), which may involve additional analytics reporting. |
| [DisableTelemetry](https://mozilla.github.io/policy-templates/#disabletelemetry) | Prevents the upload of telemetry data. As of Firefox 83 and Firefox ESR 78.5, local storage of telemetry data is disabled as well. |
| [DontCheckDefaultBrowser](https://mozilla.github.io/policy-templates/#dontcheckdefaultbrowser) | Prevents popup warnings about Firefox not being the default browser. |
| [FirefoxHome](https://mozilla.github.io/policy-templates/#firefoxhome) | Turns off stores, sponsored stories, and sponsored top sites on the Firefox Home page. |
| [GenerativeAI](https://mozilla.github.io/policy-templates/#generativeai) | Turns off all generative AI features, including AI chatbots in the sidebar, link previews, and tab group suggestions. |
| [SearchEngines](https://mozilla.github.io/policy-templates/#searchengines) | Removes Perplexity AI as a default search engine. |