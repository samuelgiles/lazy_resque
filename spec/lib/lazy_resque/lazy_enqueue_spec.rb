# frozen_string_literal: true

require 'spec_helper'

module LazyResque
  describe LazyEnqueue do
    let(:entity) { described_class.new(klass, 'my_argument', 123) }

    let(:klass) { Class }

    describe '#enqueue' do
      subject(:enqueue) { entity.enqueue }

      specify do
        expect(Resque).to receive(:enqueue).with(Class, 'my_argument', 123)
        enqueue
      end
    end
  end
end
