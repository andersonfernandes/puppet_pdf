require 'puppet_pdf/controller_helpers'

RSpec.describe ::PuppetPdf::ControllerHelpers do
  subject { HelpersImplementation.new }

  describe '#render_pdf' do
    let(:args) do
      {

      }
    end

    before { subject.render_pdf(args) }
  end
end

class HelpersImplementation
  prepend ::PuppetPdf::ControllerHelpers
end
