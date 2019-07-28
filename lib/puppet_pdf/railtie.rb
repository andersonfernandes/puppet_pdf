require 'puppet_pdf/helpers/controller'
require 'puppet_pdf/helpers/view'

module PuppetPdf
  class Railtie < Rails::Railtie
    rake_tasks do
      load 'tasks/install_dependencies.rake'
    end

    initializer 'puppet_pdf.register_helpers' do |_|
      ActionController::Base.send :prepend, PuppetPdf::Helpers::Controller
      ActionView::Base.send :include, PuppetPdf::Helpers::View
    end
  end
end
