require 'puppet_pdf/pdf_creator'
require 'puppet_pdf/controller_helpers'

RSpec.describe ::PuppetPdf::ControllerHelpers do
  subject { HelpersImplementation.new }

  describe '#render_pdf' do
    let(:args) do
      {
        template: 'report',
        layout: 'application_pdf',
        filename: 'out.pdf',
        header: '<header></header>',
        footer: '<footer></footer>',
        loading_delay: 1000
      }
    end

    let(:pdf_creator_class) { double }
    let(:pdf_creator) { instance_double('PuppetPdf::PdfCreator') }
    let(:file_path) { '/tmp/out.pdf' }

    before do
      allow(subject).to receive(:render_to_string).and_return '<html></html>'
      allow(subject).to receive(:controller_path).and_return 'tasks'
      allow(subject).to receive(:action_name).and_return 'report'
      allow(subject).to receive(:send_file).with(kind_of(String), kind_of(Hash))

      stub_const('PuppetPdf::PdfCreator', pdf_creator_class)
      allow(pdf_creator_class).to receive(:new).and_return pdf_creator
      allow(pdf_creator).to receive(:call).and_return file_path

      subject.render_pdf(args)
    end

    it 'should call PdfCreator with html and options' do
      expected_options = args.slice(:header, :footer, :margins, :loading_delay)
      expect(pdf_creator_class).to have_received(:new)
        .with(kind_of(String), expected_options)
    end

    it 'should call send_file with the file path' do
      expect(subject).to have_received(:send_file)
        .with(file_path, disposition: :inline, filename: args[:filename])
    end
  end
end

class HelpersImplementation
  prepend ::PuppetPdf::ControllerHelpers
end
