# frozen_string_literal: true

require 'lazy_resque/store'
require 'lazy_resque/lazy_enqueue'

module LazyResque
  # Extensions to append to the main Resque module to add
  # Resque.lazy_enqueue and Resque.process_lazy_enqueues
  module ResqueExtensions
    def lazy_enqueue(klass, *args)
      LazyResque::Store.queue_up(LazyResque::LazyEnqueue.new(klass, *args))
    end

    def process_lazy_enqueues
      current_queue = LazyResque::Store.queue
      return if current_queue.empty?
      Thread.new(current_queue) do |jobs_to_be_enqueued|
        jobs_to_be_enqueued.each(&:enqueue)
      end
    end
  end
end
