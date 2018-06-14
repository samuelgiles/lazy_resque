# frozen_string_literal: true

require 'resque'

module LazyResque
  # Wrap up the original klass/args ready to be placed into Store.enqueues
  class LazyEnqueue
    def initialize(klass, *args)
      @klass = klass
      @args = args
    end

    def enqueue
      Resque.enqueue(@klass, *@args)
    end
  end
end
