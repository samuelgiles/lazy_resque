# frozen_string_literal: true

require 'resque'
require 'active_support/all'

module LazyResque
  # A controller concern that appends an after_action to ensure the
  # lazily enqueued Resque enqueues during the request cycle are actually
  # enqueued at the end of the request.
  module ControllerEnqueue
    extend ActiveSupport::Concern

    included do
      append_after_action :process_lazy_enqueues
    end

    def process_lazy_enqueues
      Resque.process_lazy_enqueues
    end
  end
end
