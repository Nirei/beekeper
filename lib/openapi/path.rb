# frozen_string_literal: true

require 'openapi/operation'

module Beekeeper
  PARAMETERS_KEY = 'parameters'

  # Contains an OpenAPI path definition
  class Path
    def initialize(url, values)
      @url = url
      @parameters = parse_parameters(values)
      @operations = parse_operations(values)
    end

    attr_reader :url
    attr_reader :parameters
    attr_reader :operations

    private

    def parse_parameters(values)
      values[PARAMETERS_KEY]&.map do |parameter|
        [parameter['name'], Parameter.new(parameter)]
      end.to_h || {}
    end

    def parse_operations(values)
      operations = values.reject { |key, _value| key == PARAMETERS_KEY }

      operations.map do |method, operation|
        [method, Operation.new(method, self, operation)]
      end.to_h
    end
  end
end
