require 'puppet_pdf/version'
require 'puppet_pdf/pdf_creator'
require 'puppet_pdf/railtie' if defined?(Rails)

module PuppetPdf
  def self.pdf_from_html(html, options = {})
    pdf_creator(html, options).call
  end

  private_class_method def self.pdf_creator(source, options)
    ::PuppetPdf::PdfCreator.new(source, options)
  end
end
