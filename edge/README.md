---
layout: layout.njk
title: Microsoft Edge configuration
permalink: "edge/index.html"
---

Microsoft Edge features can be configured with group policies. This project uses Windows Registry settings on Windows, and a Profile Manager file on macOS.

You can check which policies are applied in Microsoft Edge by navigating to the `edge://policy/` page.

### Windows installation

1. Open the [registry file for installation](https://raw.githubusercontent.com/corbindavenport/just-the-browser/main/edge/install.reg) and save it (`Ctrl+S`) anywhere on your computer.
2. In the File Explorer, right-click the file and select Open with > Registry Editor.
3. Follow the prompts to install the registry keys to the Windows Registry.
5. Restart Edge.

To remove the custom configuration, follow the same steps with the [registry file for uninstallation](https://raw.githubusercontent.com/corbindavenport/just-the-browser/main/edge/uninstall.reg). This will remove the modified registry keys from your system.

### macOS installation

1. Open the [configuration file](https://raw.githubusercontent.com/corbindavenport/just-the-browser/main/edge/edge.mobileconfig) and save it (`Command+S`) anywhere on your computer.
2. In the Finder, open the configuration file you downloaded. You should see a prompt that the profile is ready for review.
3. Open the System Settings application (Apple menu > System Settings) and navigate to General > Device Management. If you are on macOS 12 Monterey or an older version, the application is called System Preferences, and you need to open the Profiles section.
4. Double-click on the 'Microsoft Edge settings' configuration, then click the Install button and follow the prompts.

To remove the custom configuration, open the Device Management settings (or Profiles pane) again, select the 'Microsoft Edge settings' configuration, and then click the remove (-) button.

### Browser settings

These are the policy settings in the Just the Browser configuration file.

| Feature | Information |
| ------- | ----------- |
| HideFirstRunExperience | The First-run experience and the splash screen will not be shown to users when they run Microsoft Edge for the first time. |
| ShowPDFDefaultRecommendationsEnabled | Prevents recommendations to set Microsoft Edge as the default PDF viewer. |
| SpotlightExperiencesAndRecommendationsEnabled | Prevents customized background images and text, suggestions, notifications, and tips for Microsoft services. |
| NewTabPageSearchBox | Redirects the search bar in the New Tab page to the address bar search, which uses the browser's default search engine, instead of just Bing. |
| GenAILocalFoundationalModelSettings | Blocks download of foundation generative AI model for local inference. |
| WebToBrowserSignInEnabled | Blocks account login prompt for Microsoft Edge when logging into the same account on a Microsoft website. |
| StartupBoostEnabled | Prevents Microsoft Edge from starting up with Windows and always running in the background. |
| NewTabPageBingChatEnabled | Blocks Copilot/Bing Chat links and suggestions from the New Tab page. |
| NewTabPageContentEnabled | Turns off content from MSN and other Microsoft services on the New Tab page. |
| NewTabPageHideDefaultTopSites | Turns off sponsored site links in the Top Sites on the New Tab page. |
| AIGenThemesEnabled | Turns off DALL-E browser themes. |
| AutoImportAtFirstRun | Blocks automatic data import from other web browsers. |
| BuiltInAIAPIsEnabled | Blocks web pages from using AI APIs, including the LanguageModel API, Summarization API, Writer API, and Rewriter API. |
| BuiltInDnsClientEnabled | Forces Edge to use the host operating system's DNS client, instead of the built-in DNS client. The built-in client is still used for DNS-over-HTTPS requests. |
| ComposeInlineEnabled | Blocks the 'Rewrite with Copilot' feature. |
| CopilotPageContext | Blocks Copilot from accessing web page context. |
| DefaultBrowserSettingEnabled | Prevents Edge from asking to be the default web browser in notifications. |
| DefaultBrowserSettingsCampaignEnabled | Prevents prompt to set Bing as the default search engine, and Edge as the default web browser. |
| DiagnosticData | Turns off all diagnostic data reporting. |
| EdgeShoppingAssistantEnabled | Turns off shopping features such as price comparison, coupons, rebates, and express checkout. |
| Microsoft365CopilotChatIconEnabled | Hides the Copilot button in the browser toolbar. |
| ShowAcrobatSubscriptionButton | Hides the 'Edit with Acrobat' button when viewing PDFs. |
| ShowMicrosoftRewards | Hides messages and notifications about Microsoft Rewards. |
| ShowRecommendationsEnabled | Hides dialog boxes, flyouts, coach marks and banners in the browser that recommend features. |
| TabServicesEnabled | Turns off sending URLs, page titles, and existing tab group information to the Microsoft tab organization service for suggesting tab groups and names. |
| TextPredictionEnabled | Turns off text prediction while typing in long text fields on web pages, powered by the [Microsoft Turing service](https://www.microsoft.com/en-us/research/project/project-turing/). |
| VisualSearchEnabled | Turns off the menu that appears when hovering the mouse over any image. Also turns off the visual search options in the context menu and sidebar search. |
| EdgeHistoryAISearchEnabled | Turns off AI-enhanced search in the browsing history. |

### Documentation

- [Microsoft Edge policy documentation and full list](https://learn.microsoft.com/en-us/DeployEdge/microsoft-edge-policies)