'use strict'

const puppeteer = require('puppeteer')
const fs = require('fs')
const path = require('path')

var log = fs.createWriteStream(path.resolve(__dirname, '/tmp/puppet_pdf.log'), { 'flags': 'a' })
process.stdout.write = process.stderr.write = log.write.bind(log)

/**
 *
 *  argv[2]   sourceType    The type of the source. Possible values: [html, url]
 *  argv[3]   source        The source of the pdf content.
 *                          If sourceType == html, source should be a path to a html file.
 *                          If sourceType == url, source should be a url to the content.
 *  argv[4]   outputPath    The path of the output pdf.
 *
 */
async function createPdf() {
  const sourceType  = process.argv[2]
  const source      = process.argv[3]
  const outputPath  = process.argv[4]

  let browser
  try {
    const browser = await getBrowser()
    const page = await getPageWithContent(browser, sourceType, source)

    await page.waitFor(1000)
    await page.pdf({
      path: outputPath,
      format: 'A4',
      margin: { top: 36, right: 36, bottom: 45, left: 36 },
      displayHeaderFooter: true,
      headerTemplate: "<header></header>",
      footerTemplate: "<footer></footer>"
    })
  } catch (err) {
    const formatedMessage = `\n ${err.message} at: ${getCurrentTimeFormated()}`
    log.write(formatedMessage)
  } finally {
    if (browser) browser.close()

    process.exit()
  }
}

async function getPageWithContent(browser, sourceType, source) {
  const page = await browser.newPage()
  const pageOptions = { timeout: 900000, waitUntil: 'networkidle0' }
  
  if(sourceType == 'html') {
    const contents = fs.readFileSync(source, 'utf8')
    await page.setContent(contents, pageOptions)
  } else if(sourceType == 'url') {
    await page.goto(source, pageOptions);
  } else {
    throw 'Invalid Source Type: Argument 3 must specify the source type of the content.'
  }

  return page
}

async function getBrowser() {
  return puppeteer.launch({
    headless: true,
    pipe: true,
    args: ['--disable-gpu', '--full-memory-crash-report', '--unlimited-storage',
      '--no-sandbox', '--disable-setuid-sandbox', '--disable-dev-shm-usage'],
  })
}

function getCurrentTimeFormated() {
  const date = new Date()
  const dateFormatted = `${date.getFullYear()}-${date.getMonth() + 1}-${date.getDate()}`

  return `${dateFormatted}, ${date.toLocaleTimeString('en')}`
}

createPdf()
