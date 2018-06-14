# frozen_string_literal: true

require 'spec_helper'

module LazyResque
  describe ResqueExtensions do
    let(:resque) do
      Class.new { extend ResqueExtensions }
    end

    describe '.lazy_enqueue' do
      subject(:perform) { resque.lazy_enqueue(Class, 123) }

      let(:lazy_enqueue) { instance_double(LazyEnqueue) }

      before do
        allow(LazyEnqueue).to receive(:new).with(Class, 123).and_return(lazy_enqueue)
      end

      specify do
        expect(Store).to receive(:queue_up).with(lazy_enqueue)
        perform
      end
    end

    describe '.process_lazy_enqueues' do
      subject(:process_lazy_enqueues) do
        thread = resque.process_lazy_enqueues
        thread ? thread.join : thread
      end

      let(:lazy_enqueue) { instance_double(LazyEnqueue) }
      let(:queue) { [] }

      before do
        allow(Store).to receive(:queue).and_return(queue)
      end

      context 'when the queue is empty' do
        specify do
          expect(lazy_enqueue).not_to receive(:enqueue)
          process_lazy_enqueues
        end
      end

      context 'when the queue is populated' do
        let(:queue) { [lazy_enqueue] }

        specify do
          expect(lazy_enqueue).to receive(:enqueue)
          process_lazy_enqueues
        end
      end
    end
  end
end
