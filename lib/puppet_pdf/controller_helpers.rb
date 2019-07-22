module PuppetPdf
  module ControllerHelpers
    def render_pdf(args = {})
      args = setup_default_args(args)
      html = render_to_string(template: args[:template],
                              layout: args[:layout],
                              locals: args[:locals])

      html_path = create_file_and_get_path(html)
      file_path = ::PuppetPdf::PdfCreator.new(:html, html_path).call

      send_file(file_path,
                filename: args[:filename],
                disposition: :inline)
    end

    private

    def setup_default_args(args = {})
      args.tap do |a|
        a[:template]      ||= File.join(controller_path, action_name)
        a[:layout]        ||= 'application'
        a[:filename]      ||= "#{action_name}.pdf"
        a[:header]        ||= '<header></header>'
        a[:footer]        ||= '<footer></footer>'
        a[:margins]       ||= { top: 36, right: 36, bottom: 45, left: 36 }
        a[:loading_delay] ||= 1000
      end
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
