require_relative 'pdf_creator'

module PuppetPdf
  module Generator
    def self.pdf_from_url(url, options={})
      pdf_creator = ::PuppetPdf::PdfCreator.new(url, options)
      pdf_creator.call
    end
  end
end
