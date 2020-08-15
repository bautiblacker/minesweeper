require 'rails_helper'

describe Api::V1::SolverController do

  describe '#index' do
    context 'when the request fails' do
      before do
        get :index
      end

      it 'responds with OK status' do
        expect(response).to have_http_status :ok
      end
    end
  end
end
