require 'puppet_pdf/controller_helpers'

module PuppetPdf
  class Railtie < Rails::Railtie
    rake_tasks do
      load 'tasks/install_dependencies.rake'
    end

    initializer 'puppet_pdf.register_helpers' do |_|
      ActionController::Base.send :prepend, PuppetPdf::ControllerHelpers
    end
  end
end
