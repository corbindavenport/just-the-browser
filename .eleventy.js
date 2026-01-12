const jsdom = require("jsdom");
const { JSDOM } = jsdom;

// Eleventy configuration
module.exports = function (eleventyConfig) {
    // Add favicon to site
    eleventyConfig.addPassthroughCopy({"media/favicon.ico": ""})
    // Add media folder to site
    eleventyConfig.addPassthroughCopy("media");
    // Modify page contents
    eleventyConfig.addTransform("update-html", async function (content) {
        const dom = new JSDOM(content);
        // Update table design
        dom.window.document.querySelectorAll('table').forEach(function (el) {
            el.classList.add('table');
        });
        // Fix header spacing in cards 
        dom.window.document.querySelectorAll('.card-body h2, .card-body h3, .card-body h4, .card-body h5, .card-body h6').forEach(function (el) {
            el.classList.add('mb-3');
        });
        // Set target blank attributes for all external links
        dom.window.document.querySelectorAll('a').forEach(function (el) {
            // Change download links to buttons
            if (el.href.startsWith('https://dl.google.com/') || el.href.startsWith('https://download.mozilla.org/') || el.href.startsWith('https://go.microsoft.com/') || el.href.startsWith('https://msedge.sf.dl.delivery.mp.microsoft.com/')) {
                el.classList.add('button')
            }
            // Open all external links in new tab
            if (el.href.startsWith('https://') || el.href.startsWith('http://')) {
                el.setAttribute('target', '_blank');
            }
        });
        return dom.serialize();
    });
};