# Just the Browser

Just the Browser helps you remove AI features, telemetry data reporting, sponsored content, product integrations, and other annoyances from desktop web browsers. The goal is to give you "just the browser" and nothing else, using hidden settings in web browsers intended for companies and other organizations.

This project includes configuration files for popular web browsers, documentation for installing and modifying them, and easy installation scripts.

![Screenshot of setup utility on Windows and macOS](media/screen.png)

## Install script

**Windows:** Open a PowerShell prompt as Administrator. You can do this by right-clicking the Windows button in the taskbar, then selecting the "Terminal (Admin)" or "PowerShell (Admin)" menu option. Next, copy the below command, paste it into the window (`Ctrl+V`), and press the Enter/Return key:

```powershell
& ([scriptblock]::Create((irm "https://raw.githubusercontent.com/corbindavenport/just-the-browser/main/main.ps1")))
```

**Mac and Linux:** Search for the Terminal in your applications list and open it. Next, copy the below command, paste it into the window (`Ctrl+V` or `Cmd+V`), and press the Enter/Return key:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/corbindavenport/just-the-browser/main/main.sh)"
```

## Documentation and config files

See the [Google Chrome](chrome/README.md), [Microsoft Edge](edge/README.md), and [Mozilla Firefox](firefox/README.md) documentation pages for manual installation instructions, and explanations for each setting. The browser directories also contain the configuration files.

Firefox uses a JSON file for all platforms. Chrome and Edge have [Windows Registry .reg](https://en.wikipedia.org/wiki/Windows_Registry#.REG_files) files for installation and removal on Windows, and [Profile Manager .mobileconfig](https://support.apple.com/guide/profile-manager/distribute-profiles-manually-pmdbd71ebc9/mac) files for macOS.

## Website

This repository also includes the static site generator for [justthebrowser.com](https://justthebrowser.com/), built with [Eleventy](https://www.11ty.dev/) and [Simple.css](https://simplecss.org/). The icons are from [Bootstrap Icons](https://icons.getbootstrap.com/).

With Node.js and NPM installed, you can test the site like this:

```shell
npm install
npx @11ty/eleventy --serve
```

The site is compiled and deployed with the `eleventy_build.yml` GitHub Action.