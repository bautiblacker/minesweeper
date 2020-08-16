require 'rails_helper'

describe SolverController do
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
