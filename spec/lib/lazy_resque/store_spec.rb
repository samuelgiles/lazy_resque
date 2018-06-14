# frozen_string_literal: true

require 'spec_helper'

module LazyResque
  describe Store do
    before do
      RequestLocals.store[:lazy_resque_queue] = nil
    end

    describe '.queue' do
      subject(:queue) { described_class.queue }

      context 'when the queue is empty' do
        it { is_expected.to eq [] }
      end

      context 'when the queue is populated' do
        let(:lazy_enqueue) { instance_double(LazyEnqueue) }

        before do
          RequestLocals.store[:lazy_resque_queue] = [lazy_enqueue]
        end

        it { is_expected.to contain_exactly(lazy_enqueue) }
      end
    end

    describe '.queue_up' do
      subject(:queue_up) { described_class.queue_up(lazy_enqueue) }

      let(:lazy_enqueue) { instance_double(LazyEnqueue) }

      specify do
        queue_up
        expect(RequestLocals.store[:lazy_resque_queue])
          .to contain_exactly(lazy_enqueue)
      end
    end
  end
end
