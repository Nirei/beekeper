# frozen_string_literal: true

module Beekeeper
  # Contains an OpenAPI operation definition
  class Operation
    def initialize(method, path, operation)
      @method = method
      @path = path
      @operation_id = operation['operationId']
      @tags = operation['tags'] || []
      @summary = operation['summary']
      @description = operation['description']

      @parameters = parse_parameters(operation)
      @responses = parse_responses(operation_id, operation)

      puts method
      puts path
      puts operation
      puts
    end

    attr_reader :method
    attr_reader :path
    attr_reader :tags
    attr_reader :operation_id
    attr_reader :summary
    attr_reader :description
    attr_reader :parameters
    attr_reader :responses

    def parse_parameters(operation)
      # TODO: Implement
      nil
    end

    def parse_responses(operation_id, operation)
      # TODO: Implement
      nil
    end
  end
end
