module Utils
  module YarnWrapper
    def run_yarn(command, *args)
      system("cd #{gem_path} && yarn #{command.to_s} #{args.join('  ')}")
    end

    def validate_yarn_installation
      which_yarn_output = `which yarn`

      raise 'Yarn not installed!' if which_yarn_output.empty?
    end

    private

    def gem_path
      @gem_path ||= Gem.loaded_specs['puppet_pdf'].full_gem_path
    end
  end
end
