
# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lazy_resque/version'

Gem::Specification.new do |spec|
  spec.name          = 'lazy_resque'
  spec.version       = LazyResque::VERSION
  spec.authors       = ['Bellroy Tech Team']
  spec.email         = ['tech@bellroy.com']

  spec.summary       = 'Lazy Resque'
  spec.description   = 'Moves Resque enqueues out of the request cycle in a Rails application.'
  spec.homepage      = 'https://github.com/samuelgiles/lazy_resque'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '>= 1.13'
  spec.add_development_dependency 'rake', '>= 10.0'
  spec.add_development_dependency 'rspec', '>= 3.0'
  spec.add_runtime_dependency 'activesupport', '>= 5.0.0'
  spec.add_runtime_dependency 'request_store_rails', '>= 1.0.3'
  spec.add_runtime_dependency 'resque'
end
