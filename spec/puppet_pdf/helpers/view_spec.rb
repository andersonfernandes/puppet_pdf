require 'puppet_pdf/helpers/view'

RSpec.describe ::PuppetPdf::Helpers::View do
  subject { ViewImplementation.new }

  let(:open_uri_class) { double }

  describe '#puppet_stylesheet_link_tag' do
    let(:asset_content) { 'body { color: red; }' }
    let(:asset_url) { 'http://localhost:3000/asset/application.css' }
    let(:asset) { 'application.css' }

    before do
      stub_const('OpenURI', open_uri_class)
      allow(subject).to receive(:asset_url).with(asset).and_return asset_url
      allow(open_uri_class).to receive(:open_uri).and_return(asset_content)
    end

    it 'should return a style tag with the content of the given asset' do
      expected_tag = <<~TAG
        <style type='text/css'>
          #{asset_content}
        </style>
      TAG
      expect(subject.puppet_stylesheet_link_tag(asset))
        .to eq(expected_tag)
    end
  end

  describe '#puppet_javascript_script_tag' do
    let(:asset_content) { "alert('hello')" }
    let(:asset_url) { 'http://localhost:3000/asset/application.js' }
    let(:asset) { 'application.js' }

    before do
      stub_const('OpenURI', open_uri_class)
      allow(subject).to receive(:asset_url).with(asset).and_return asset_url
      allow(open_uri_class).to receive(:open_uri).and_return(asset_content)
    end

    it 'should return a style tag with the content of the given asset' do
      expected_tag = <<~TAG
        <script type='application/javascript'>
          #{asset_content}
        </script>
      TAG
      expect(subject.puppet_javascript_script_tag(asset))
        .to eq(expected_tag)
    end
  end
end

class ViewImplementation
  prepend ::PuppetPdf::Helpers::View
end
