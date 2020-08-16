require 'rails_helper'

describe Solver do
  let(:solver_service) {described_class.new}

  describe '#call' do
    context 'when the request succeed' do
      it 'expects to not raise error' do
        expect{ Solver.call }.not_to raise_error(Solver::RequestError)
      end
    end
  end

  describe '#handle_response_body' do
    context 'when the parsed response is an array' do
      let(:parsed_response) { '[]' }

      it 'expects to not raise error' do
        expect{ Solver.handle_response_body(parsed_response) }.not_to raise_error(Solver::ParsingError)
      end
    end

    context 'when the parsed response is not an array' do
      let(:parsed_response) { '123' }
      it 'expects to raise error' do
        expect{ Solver.handle_response_body(parsed_response) }.to raise_error(Solver::ParsingError)
      end
    end
  end

end