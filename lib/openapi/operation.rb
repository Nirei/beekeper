# frozen_string_literal: true

require 'openapi/parameter'

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
      @request_body = parse_request_body(operation)
      @responses = parse_responses(operation)
    end

    attr_reader :method
    attr_reader :path
    attr_reader :tags
    attr_reader :operation_id
    attr_reader :summary
    attr_reader :description
    attr_reader :parameters
    attr_reader :request_body
    attr_reader :responses

    private

    def parse_parameters(operation)
      operation['parameters']&.map do |parameter|
        [parameter['name'], Parameter.new(parameter)]
      end.to_h || {}
    end

    def parse_request_body(operation)
      # TODO: Support other types of data besides application/json
      request_body_schema = operation.dig 'requestBody', 'content', 'application/json', 'schema'
      return if request_body_schema.nil?

      SchemaFactory.parse(request_body_schema)
    end

    def parse_responses(_operation)
      # TODO: Implement
      nil
    end
  end
end
