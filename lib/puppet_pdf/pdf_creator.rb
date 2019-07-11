require 'tempfile'
require 'utils/yarn_wrapper'

module PuppetPdf
  class PdfCreator
    include ::Utils::YarnWrapper

    def initialize(task, source, options = {})
      validate_yarn_installation

      @task = task
      @source = source
      @output_path = options.fetch(:output_path, default_output_path)
    end

    def call
      run_yarn(task, source, output_path)
      output_path
    end

    private

    attr_reader :task, :source, :output_path

    def default_output_path
      file = Tempfile.new(["puppet_pdf_#{Time.now.to_i}", '.pdf'])
      file.path
    end
  end
end
