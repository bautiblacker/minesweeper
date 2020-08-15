# frozen_string_literal: true
require 'net/http'.freeze
require 'uri'.freeze
require 'json'.freeze

class Solver
  class RequestError < StandardError; end

  BASE_URL = 'https://mine-sweeper-generator.herokuapp.com/solver'.freeze

  def self.call
    escaped_address = URI.URI.encode_www_form(BASE_URL)
    uri = URI.parse(escaped_address)
    response = Net::HTTP.get_response(uri)
    raise RequestError.new, 'Bad Request' unless response.code == '200'

    handle_response_body(response.body)
  end

  def self.handle_response_body(response)
    minesweeper = JSON.parse(response)
    problem = minesweeper.map(&:clone)
    answer = solve(minesweeper)
    { problem: problem, answer: answer }
  end

  def self.solve(matrix)
    matrix_size = matrix.size
    unless matrix_size.zero?
      (0...matrix.size).each do |row_index|
        (0...matrix.size).each do |col_index|
          matrix[row_index][col_index] = count_mines(row_index, col_index, matrix) if matrix[row_index][col_index] == ' ' # rubocop:disable Layout/LineLength: Line is too long
        end
      end
    end
    matrix
  end

  def self.count_mines(row_index, col_index, matrix)
    interval = (-1..1)
    counter = 0
    interval.each do |row_value|
      interval.each do |col_value|
        row_aux = row_index + row_value
        col_aux = col_index + col_value
        counter += 1 if validate_indexes(row_aux, col_aux, matrix) && matrix[row_aux][col_aux] == '*'
      end
    end
    counter
  end

  def self.validate_indexes(row_index, col_index, matrix)
    row_index >= 0 && col_index >= 0 && row_index < matrix.size && col_index < matrix.size
  end
end
