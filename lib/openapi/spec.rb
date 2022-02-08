# frozen_string_literal: true

require 'openapi/model'

module Beekeeper
  # Represents an OpenAPI spec
  class Spec
    def initialize(spec)
      @operations = parse_operations(spec).freeze
      @models = parse_models(spec).freeze
    end

    attr_reader :operations
    attr_reader :models

    private

    def parse_operations(spec)
      # TODO: Implement me
      []
    end

    def parse_models(spec)
      models = spec.dig 'components', 'schemas'
      models ||= []
      models.map { |(_name, model)| Model.new(model) }
    end
  end
end
