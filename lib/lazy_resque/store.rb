# frozen_string_literal: true

require 'request_store_rails'

module LazyResque
  # Per thread store that uses RequestLocals to store all the enqueues
  # we want to run
  module Store
    def self.queue
      RequestLocals.fetch(:lazy_resque_queue) { [] } || []
    end

    def self.queue_up(lazy_enqueue)
      RequestLocals.store[:lazy_resque_queue] = queue.concat([lazy_enqueue])
    end
  end
end
