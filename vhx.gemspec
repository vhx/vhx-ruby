lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vhx/version'

Gem::Specification.new do |spec|
  spec.name           = 'vhx-ruby'
  spec.version        = Vhx::VERSION
  spec.authors        = ['Sagar Shah']
  spec.date           = '2015-01-29'
  spec.description    = 'A Ruby wrapper for the Vhx developer API.'
  spec.summary        = 'A Ruby wrapper for the Vhx developer API.'
  spec.email          = 'sagar@vhx.tv'
  spec.homepage       = 'http://dev.vhx.tv/docs/api/'
  spec.license        = 'MIT'

  spec.files          = `git ls-files`.split("\n")
  spec.executables    = spec.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  spec.test_files     = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths  = ['lib']

  # Gems that must be intalled
  spec.add_dependency "faraday"
  spec.add_dependency "multi_json"
  spec.add_dependency "oauth2"
end