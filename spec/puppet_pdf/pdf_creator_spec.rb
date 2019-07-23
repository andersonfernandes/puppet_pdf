require 'puppet_pdf/pdf_creator'

RSpec.describe ::PuppetPdf::PdfCreator do
  let(:source) { 'source.html' }
  let(:options) { {} }

  subject { described_class.new(source, options) }

  describe 'initialization' do
    context 'with a valid yarn installation' do
      it 'should not raise error' do
        expect { subject }.not_to raise_error
      end

      it 'should set source and options instance variables' do
        expect(subject.source).to eq source
        expect(subject.options).not_to be_nil
      end
    end

    context 'with an invalid yarn installation' do
      let(:yarn_not_installed) { 'Yarn not installed!' }

      before do
        allow_any_instance_of(described_class)
          .to receive(:validate_yarn_installation)
          .and_raise(yarn_not_installed)
      end

      it 'should raise yarn not installed error' do
        expect { subject }
          .to raise_error(yarn_not_installed)
      end
    end
  end

  describe '#call' do
    before do
      allow_any_instance_of(described_class).to receive(:run_yarn)
      subject.call
    end

    it do
      expect(subject).to have_received(:run_yarn)
        .with(:create_pdf, source, kind_of(String))
    end

    context 'when options have output_path set' do
      let(:options) { { output_path: '/tmp/out.pdf' } }

      it 'should return the output_path' do
        expect(subject.call).to eq options[:output_path]
      end
    end
  end
end
