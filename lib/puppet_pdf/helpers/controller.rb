module PuppetPdf
  module Helpers
    module Controller
      def render_pdf(args = {})
        html = render_to_string(render_params(args))

        html_path = create_file_and_get_path(html)
        options = args.slice(:header, :footer, :margins, :loading_delay)
        file_path = ::PuppetPdf::PdfCreator.new(html_path, options).call

        send_file(file_path,
                  filename: args.fetch(:filename, "#{action_name}.pdf"),
                  disposition: :inline)
      end

      private

      def render_params(params)
        {
          template: params.fetch(:template, default_template),
          layout: params.fetch(:layout, 'application'),
          locals: params.fetch(:locals, {})
        }
      end

      def default_template
        File.join(controller_path, action_name)
      end

      def create_file_and_get_path(content)
        file = Tempfile.new(Time.now.to_i.to_s)
        file_path = file.path
        file.write(content)
        file.close

        file_path
      end
    end
  end
end
