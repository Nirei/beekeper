# frozen_string_literal: true

require 'openapi/operation'

module Beekeeper
  # Contains an OpenAPI path definition
  class Path
    def initialize(path, values)
      @path = path
      @parameters = parse_parameters(path, values)
      @operations = parse_operations(path, values)
    end

    attr_reader :path
    attr_reader :parameters
    attr_reader :operations

    private

    def parse_parameters(path, values)
      operations = values.select { |key, _value| key == 'parameters' }
      # TODO: Implement!!
      nil
    end

    def parse_operations(path, values)
      operations = values.reject { |key, _value| key == 'parameters' }

      operations.map do |method, operation|
        [method, Operation.new(method, path, operation)]
      end.to_h
    end
  end
end
