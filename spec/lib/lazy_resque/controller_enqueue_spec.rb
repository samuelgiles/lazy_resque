# frozen_string_literal: true

require 'spec_helper'

module LazyResque
  describe ControllerEnqueue do
    let(:controller) do
      Class.new do
        def self.append_after_action(action_name)
          action_name
        end
      end
    end

    before do
      expect(controller)
        .to receive(:append_after_action)
        .with(:process_lazy_enqueues)
      controller.include described_class
    end

    describe '#process_lazy_enqueues' do
      subject(:process_lazy_enqueues) do
        controller_instance.process_lazy_enqueues
      end

      let(:controller_instance) { controller.new }

      specify do
        expect(Resque).to receive(:process_lazy_enqueues)
        process_lazy_enqueues
      end
    end
  end
end
