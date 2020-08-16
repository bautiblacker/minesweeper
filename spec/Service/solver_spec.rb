require 'rails_helper'

describe Solver do
  describe '#call' do
    context 'when the request succeed' do
      it 'expects to not raise error' do
        expect { described_class.call }.not_to raise_error(Errors::RequestError)
      end
    end
  end
end
