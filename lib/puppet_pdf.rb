require 'puppet_pdf/version'
require 'puppet_pdf/pdf_creator'
require 'puppet_pdf/railtie' if defined?(Rails)

module PuppetPdf
  def self.pdf_from_url(url, options = {})
    pdf_creator = ::PuppetPdf::PdfCreator.new(url, options)
    pdf_creator.call
  end
end
