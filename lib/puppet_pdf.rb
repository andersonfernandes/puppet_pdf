require 'puppet_pdf/version'
require 'puppet_pdf/pdf_creator'
require 'puppet_pdf/railtie' if defined?(Rails)

module PuppetPdf
  def self.pdf_from_url(url, options = {})
    pdf_creator(:url, url, options).call
  end

  def self.pdf_from_html(html, options = {})
    pdf_creator(:html, html, options).call
  end

  private_class_method def self.pdf_creator(source_type, source, options)
    ::PuppetPdf::PdfCreator.new(source_type, source, options)
  end
end
