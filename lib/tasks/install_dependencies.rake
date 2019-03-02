namespace :puppet_pdf do
  desc 'Intall dependencies of Puppet PDF'
  task :install_dependencies do
    gem_path = Gem.loaded_specs['puppet_pdf'].full_gem_path
    system("cd #{gem_path} && yarn install")
  end
end
