'use strict';

const puppeteer = require('puppeteer');
const fs = require('fs')
const path = require('path')

function getCurrentTimeFormated() {
  const date = new Date();
  const dateFormatted = `${date.getFullYear()}-${date.getMonth() + 1}-${date.getDate()}`

  return `${dateFormatted}, ${date.toLocaleTimeString('en')}`
}

var access = fs.createWriteStream(path.resolve(__dirname, '/tmp/puppeteer.log'), { 'flags': 'a' });
// Redirect stdout/stderr to puppeteer.log file
process.stdout.write = process.stderr.write = access.write.bind(access);

const pdf_from_html = async () => {
  let browser;
  try {
     const browser = await puppeteer.launch({
       headless: true,
       pipe: true,
       args: ['--disable-gpu', '--full-memory-crash-report', '--unlimited-storage',
         '--no-sandbox', '--disable-setuid-sandbox', '--disable-dev-shm-usage'],
    });
    const page = await browser.newPage();
    await page.setContent(process.argv[2])
    await page.waitFor(1000);
    await page.pdf({
      path: process.argv[3],
      format: 'A4',
      margin: { top: 36, right: 36, bottom: 45, left: 36 },
      displayHeaderFooter: true,
      headerTemplate: "<div></div>",
      footerTemplate: "<div></div>"
    });
  } catch (err) {
    const formatedMessage = `\n ${err.message} at: ${getCurrentTimeFormated()}`;
    access.write(formatedMessage)
  } finally {
    if (browser) {
      browser.close();
    }
    process.exit();
  }
};

pdf_from_html();

