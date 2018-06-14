# frozen_string_literal: true

require 'lazy_resque/version'
require 'lazy_resque/lazy_enqueue'
require 'lazy_resque/resque_extensions'
require 'lazy_resque/controller_enqueue'

Resque.extend(LazyResque::ResqueExtensions)
