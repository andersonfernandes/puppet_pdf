lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'puppet_pdf/version'

Gem::Specification.new do |spec|
  spec.name          = 'puppet_pdf'
  spec.version       = PuppetPdf::VERSION
  spec.authors       = ['Anderson Fernandes']
  spec.email         = ['fernandesanderson14@gmail.com']

  spec.summary       = 'Simple PDF generator based on Google Puppeteer'
  spec.homepage      = 'https://github.com/andersonfernandes/puppet_pdf'
  spec.license       = 'MIT'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'pry', '~> 0.12.2'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.72.0'

  spec.add_dependency 'activerecord', '~> 5.0', '>= 5.0.0.1'
  spec.add_dependency 'railties', '~> 5.2', '>= 5.2.3'
end
