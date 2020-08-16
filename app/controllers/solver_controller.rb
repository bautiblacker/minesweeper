# frozen_string_literal: true

# SolverController
class SolverController < ApplicationController
  def index
    solution = Solver.call
    render json: { problem: solution[:problem], solution: solution[:answer] }, status: :ok
  rescue Errors::RequestError => e
    render json: { bad_request: e.message }, status: :bad_request
  rescue StandardError => e
    render json: { error_message: e.message }, status: :internal_server_error
  end
end
