module PuppetPdf
  module Helpers
    def pdf_from(source_type, source)
      validate_source_type(source_type)

      create_pdf_methods[source_type].call(source_type, source)
    end

    private

    def validate_source_type(source_type)
      source_types = %i[url html]

      raise 'Invalid source type!' unless source_types.include?(source_type)
    end

    def create_pdf_methods
      {
        html: lambda do |source_type, source|
          file_path = create_file(source)
          ::PuppetPdf::PdfCreator.new(source_type, file_path).call
        end,
        url: lambda do |source_type, source|
          ::PuppetPdf::PdfCreator.new(source_type, source).call
        end
      }
    end

    def create_file(html)
      file = Tempfile.new(Time.now.to_i.to_s)
      file_path = file.path
      file.write(html)
      file.close

      file_path
    end
  end
end
