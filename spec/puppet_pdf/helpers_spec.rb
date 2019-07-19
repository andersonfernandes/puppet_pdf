require 'puppet_pdf/helpers'

RSpec.describe ::PuppetPdf::Helpers do
  subject { HelpersImplementation.new }

  describe '#pdf_from' do
    let(:source_type) { :html }
    let(:source) { 'source' }
    let(:action_call) { subject.pdf_from(source_type, source) }

    context 'with an invalid source_type' do
      let(:source_type) { :invalid_source_type }

      it 'should raise an exception' do
        expect { action_call }.to raise_error('Invalid source type!')
      end
    end

    context 'with a valid source_type' do
      it 'should not raise an exception' do
        expect { action_call }.not_to raise_error
      end
    end
  end
end

class HelpersImplementation
  prepend ::PuppetPdf::Helpers
end
