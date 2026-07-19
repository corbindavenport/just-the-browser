const jsdom = require("jsdom");
const { JSDOM } = jsdom;

// Eleventy configuration
module.exports = function (eleventyConfig) {
    // Ignore source docs
    eleventyConfig.ignores.add("README.md");
    eleventyConfig.ignores.add("CONTRIBUTING.md");
    // Add favicon to root directory
    eleventyConfig.addPassthroughCopy({"media/favicon.ico": "/favicon.ico"})
    // Add media folder
    eleventyConfig.addPassthroughCopy("media");
    // Modify page contents
    eleventyConfig.addTransform("update-html", async function (content) {
        const dom = new JSDOM(content);
        // Set target blank attributes for all external links
        dom.window.document.querySelectorAll('a').forEach(function (el) {
            // Change download links to buttons
            if (el.href.startsWith('https://dl.google.com/') || el.href.startsWith('https://download.mozilla.org/') || el.href.startsWith('https://go.microsoft.com/') || el.href.startsWith('https://msedge.sf.dl.delivery.mp.microsoft.com/')) {
                el.classList.add('button');
            }
            // Change donate links to full-width donate buttons
            if (el.href.startsWith('https://www.patreon.com/') || el.href.startsWith('https://www.paypal.com/') || el.href.startsWith('https://cash.app/')) {
                el.classList.add('button');
                el.setAttribute('style', 'width: 100%; text-align: center;');
            }
            // Open all external links in new tab
            if (el.href.startsWith('https://') || el.href.startsWith('http://')) {
                el.setAttribute('target', '_blank');
            }
        });
        return dom.serialize();
    });
    // Force exit on site builds, because there's sometimes a hanging process
    if (process.env.ELEVENTY_ENV === "production" || !process.argv.includes("--serve")) {
        eleventyConfig.on("eleventy.after", function () {
            console.log("Forcing exit...");
            process.exit(0);
        });
    }
};