# frozen_string_literal: true

source 'https://rubygems.org'

# Specify your gem's dependencies in lazy_resque.gemspec
gemspec

group :development, :test do
  gem 'activesupport'
  gem 'guard-livereload', require: false
  gem 'guard-rspec'
  gem 'pry-byebug'
  gem 'rb-fsevent', require: false
  gem 'rb-readline'
  gem 'reek'
  gem 'request_store_rails'
  gem 'resque'
  gem 'rspec'
  gem 'rubocop'
  gem 'rubocop-rspec'
end

group :development do
  gem 'spring'
  gem 'spring-watcher-listen'
end

group :test do
  gem 'simplecov'
  gem 'spring-commands-rspec'
end
