module PuppetPdf
  class PdfCreator
    def initialize(url, options = {})
      # TODO Check yarn installation
      @url = url
      default_output_path = "/tmp/puppet_pdf_#{Time.now.to_i}.pdf"
      @output_path = options.fetch(:output_path, default_output_path)
    end

    def call
      system("yarn createPDF #{url} #{output_path}")
    end

    attr_reader :url, :output_path
  end
end
