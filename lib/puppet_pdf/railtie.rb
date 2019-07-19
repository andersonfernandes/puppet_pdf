require 'puppet_pdf/helpers'

module PuppetPdf
  class Railtie < Rails::Railtie
    rake_tasks do
      load 'tasks/install_dependencies.rake'
    end

    initializer 'puppet_pdf.register_helpers' do |_|
      ActionController::Base.send :prepend, PuppetPdf::Helpers
    end
  end
end
