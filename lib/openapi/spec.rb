# frozen_string_literal: true

require 'openapi/model'
require 'openapi/operation'

module Beekeeper
  # Represents an OpenAPI spec
  class Spec
    def initialize(spec)
      @openapi_version = (spec['openapi']) || ''
      @title = spec.dig('info', 'title') || ''
      @version = spec.dig('info', 'version') || ''
      @tags = spec['tags'] || []

      @operations = parse_operations(spec)
      @models = parse_models(spec)
    end

    attr_reader :openapi_version
    attr_reader :title
    attr_reader :version

    attr_reader :tags
    attr_reader :operations
    attr_reader :models

    private

    def parse_operations(spec)
      paths = spec['paths'] || []
      paths.map do |path, values|
        operations = values.reject { |key, _value| key == 'parameters' }

        operations.map do |method, operation|
          Operation.new(method, path, operation)
        end
      end
    end

    def parse_models(spec)
      models = spec.dig 'components', 'schemas'
      models ||= []
      # TODO: Append endpoint inline models
      models.map { |(_name, model)| Model.new(model) }
    end
  end
end
