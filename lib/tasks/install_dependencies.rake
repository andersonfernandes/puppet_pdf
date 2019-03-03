require 'utils/yarn_wrapper'

namespace :puppet_pdf do
  include ::Utils::YarnWrapper

  desc 'Install js dependencies of Puppet PDF'
  task :install_dependencies do
    validate_yarn_installation
    run_yarn(:install)
  end
end
