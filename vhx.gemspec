lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vhx/version'

Gem::Specification.new do |spec|
  spec.name           = 'vhx-ruby'
  spec.version        = Vhx::VERSION
  spec.authors        = ['Vimeo OTT Developers']
  spec.date           = '2020-01-27'
  spec.description    = 'A Ruby wrapper for the VHX developer API.'
  spec.summary        = 'A Ruby wrapper for the VHX developer API.'
  spec.email          = ['dev@vhx.tv']
  spec.homepage       = 'http://dev.vhx.tv/docs/api/'
  spec.license        = 'MIT'

  spec.files          = `git ls-files`.split("\n")
  spec.executables    = spec.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  spec.test_files     = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths  = ['lib']

  # Gems that must be installed
  spec.add_dependency 'faraday', '~> 0.9'
  spec.add_dependency 'faraday_middleware', '~> 0.9'

  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'webmock'
end
