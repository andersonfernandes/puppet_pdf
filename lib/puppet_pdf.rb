require 'puppet_pdf/version'
require 'puppet_pdf/pdf_creator'
require 'puppet_pdf/railtie' if defined?(Rails)

module PuppetPdf
  def self.pdf_from_url(url, options = {})
    pdf_creator(:pdf_from_url, url, options).call
  end

  def self.pdf_from_html(html, options = {})
    pdf_creator(:pdf_from_html, html, options).call
  end

  private_class_method def self.pdf_creator(task, source, options)
    ::PuppetPdf::PdfCreator.new(task, source, options)
  end
end
