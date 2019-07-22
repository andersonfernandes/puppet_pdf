'use strict'

const puppeteer = require('puppeteer')
const fs = require('fs')
const path = require('path')

var log = fs.createWriteStream(path.resolve(__dirname, '/tmp/puppet_pdf.log'), { 'flags': 'a' })
process.stdout.write = process.stderr.write = log.write.bind(log)

const defaultOptions = {
  header: "<header></header>",
  footer: "<footer></footer>",
  loadingDelay: 1000,
  margin: { top: 36, right: 36, bottom: 45, left: 36 }
}

/**
 *
 *  argv[2]   source        The source of the pdf content.
 *  argv[3]   options       A JSON with the pdf creation options.
 *                          The available options are: 
 *                            - outputPath
 *                            - header
 *                            - footer
 *                            - loadingDelay
 *                            - margin: { :top, :right, :bottom, :left }
 *
 */
async function createPdf() {
  const source  = process.argv[2]
  const options = JSON.parse(process.argv[3])

  if(Object.is(options.outputPath, undefined)) throw 'You must provide the outputPath option'

  let browser
  try {
    const browser = await getBrowser()
    const page = await getPageWithContent(browser, source)

    await page.waitFor(getOption('loadingDelay', options))
    await page.pdf({
      path: options.outputPath,
      format: 'A4',
      margin: getOption('margin', options),
      displayHeaderFooter: true,
      headerTemplate: getOption('header', options),
      footerTemplate: getOption('footer', options),
    })
  } catch (err) {
    const formatedMessage = `\n ${err.message} at: ${getCurrentTimeFormated()}`
    log.write(formatedMessage)
  } finally {
    if (browser) browser.close()

    process.exit()
  }
}

async function getPageWithContent(browser, source) {
  const page = await browser.newPage()
  const pageOptions = { timeout: 900000, waitUntil: 'networkidle0' }

  const contents = fs.readFileSync(source, 'utf8')
  await page.setContent(contents, pageOptions)

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

function getOption(key, options) {
  return Object.is(options[key], undefined) ? defaultOptions[key] : options[key]
}

function getCurrentTimeFormated() {
  const date = new Date()
  const dateFormatted = `${date.getFullYear()}-${date.getMonth() + 1}-${date.getDate()}`

  return `${dateFormatted}, ${date.toLocaleTimeString('en')}`
}

createPdf()
