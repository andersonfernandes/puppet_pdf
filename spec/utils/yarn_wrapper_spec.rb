RSpec.describe ::Utils::YarnWrapper do
  subject { YarnWrapperCaller.new }

  describe '#run_yarn' do
    let(:gem_path) { '/tmp/' }
    let(:command) { :install }

    before do
      allow(subject).to receive(:gem_path).and_return gem_path
      allow(subject).to receive(:system)
      subject.run_yarn(command)
    end

    context 'when command and args are valid' do
      it 'subject should receive the expected message' do
        expected_message = "cd #{gem_path} && yarn #{command} \n"
        expect(subject).to have_received(:system).with expected_message
      end
    end
  end

  describe '#validate_yarn_installation' do
    let(:which_yarn_output) { '/bin/yarn' }

    before do
      allow(subject).to receive(:which_yarn_output).and_return which_yarn_output
    end

    context 'when yarn is installed' do
      it 'should not raise error' do
        expect { subject.validate_yarn_installation }.not_to raise_error
      end
    end

    context 'when yarn is not installed' do
      let(:which_yarn_output) { '' }

      it 'should not raise error' do
        expect { subject.validate_yarn_installation }
          .to raise_error('Yarn not installed!')
      end
    end
  end
end

class YarnWrapperCaller
  include ::Utils::YarnWrapper
end
