module PuppetPdf
  class Railtie < Rails::Railtie
    rake_tasks do
      load 'tasks/install_dependencies.rake'
    end
  end
end
