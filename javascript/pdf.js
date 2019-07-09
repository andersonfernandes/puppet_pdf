'use strict';

const puppeteer = require('puppeteer');
const fs = require('fs')
const path = require('path')

function getCurrentTimeFormated() {
  const date = new Date();
  const dateFormatted = `${date.getDate()}/${date.getMonth() + 1}/${date.getFullYear()}`

  return `${dateFormatted}, ${date.toLocaleTimeString('pt-BR')}`
}

var access = fs.createWriteStream(path.resolve(__dirname, '/tmp/puppeteer.log'), { 'flags': 'a' });
// Redirect stdout/stderr to puppeteer.log file
process.stdout.write = process.stderr.write = access.write.bind(access);

const createPdf = async () => {
  let browser;
  try {
     const browser = await puppeteer.launch({
       headless: true,
       pipe: true,
       args: ['--disable-gpu', '--full-memory-crash-report', '--unlimited-storage',
         '--no-sandbox', '--disable-setuid-sandbox', '--disable-dev-shm-usage'],
    });
    const page = await browser.newPage();
    await page.goto(process.argv[2], { timeout: 900000, waitUntil: 'networkidle0' });
    await page.waitFor(1000);
    await page.pdf({
      path: process.argv[3],
      format: 'A4',
      margin: { top: 36, right: 36, bottom: 45, left: 36 },
      displayHeaderFooter: true,
      headerTemplate: "<div></div>",
      footerTemplate: `
        <footer style="width: 100%; font-size: 8px; font-family: Helvetica; color: #DCDCDC">
          <div style="margin-left: 36px; float: left">Generated at: ${getCurrentTimeFormated()}</div>
        </footer>
      `
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

createPdf();

