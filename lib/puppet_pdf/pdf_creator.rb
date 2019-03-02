module PuppetPdf
  class PdfCreator
    def initialize(url, options = {})
      raise_error_if_yarn_not_present

      @url = url
      @output_path = options.fetch(:output_path, default_output_path)
    end

    def call
      gem_path = Gem.loaded_specs['puppet_pdf'].full_gem_path
      system("cd #{gem_path} && yarn createPDF #{url} #{output_path}")
    end

    private

    attr_reader :url, :output_path

    def raise_error_if_yarn_not_present
      which_yarn_output = `which yarn`

      raise 'Yarn not installed!' if which_yarn_output.empty?
    end

    def default_output_path
      file = Tempfile.new(["puppet_pdf_#{Time.now.to_i}", '.pdf']) 
      file.path
    end
  end
end
