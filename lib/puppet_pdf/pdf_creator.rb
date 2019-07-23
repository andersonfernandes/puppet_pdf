require 'tempfile'
require 'utils/yarn_wrapper'
require 'json'

module PuppetPdf
  class PdfCreator
    include ::Utils::YarnWrapper

    attr_reader :source, :options

    def initialize(source, options = {})
      validate_yarn_installation

      @source   = source
      @options  = options.tap do |opt|
        opt[:output_path] = opt.fetch(:output_path, default_output_path)
      end
    end

    def call
      run_yarn(:create_pdf, source, options_json)
      options[:output_path]
    end

    private

    def options_json
      options
        .each_with_object({}) { |(key, val), opts| opts[camelize(key)] = val }
        .to_json
    end

    def camelize(string)
      string_arr = string.to_s.split('_')
      head, *tail = string_arr

      head.downcase + tail.map(&:capitalize).join
    end

    def default_output_path
      file = Tempfile.new(["puppet_pdf_#{Time.now.to_i}", '.pdf'])
      file.path
    end
  end
end
