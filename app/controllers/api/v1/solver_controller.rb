# frozen_string_literal: true

require 'solver.rb'

# SolverController
module Api
  module V1
    class SolverController < ApplicationController
      def index
        solution = Solver.call
        render json: { problem: solution[:problem], solution: solution[:answer] }, status: :ok
      rescue Solver::RequestError => e
        render json: { bad_request: e.message }, status: :bad_request
      rescue StandardError => e
        render json: { error_message: e.message }, status: :internal_server_error
      end
    end
  end
end
