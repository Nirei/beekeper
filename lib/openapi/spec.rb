# frozen_string_literal: true

require 'openapi/model'

module Apiculturist
  # Represents an OpenAPI spec
  class Spec
    def initialize(spec)
      @operations = parse_operations(spec)
      @models = parse_models(spec)
    end

    attr_reader :operations
    attr_reader :models

    private

    def parse_operations(spec); end

    def parse_models(spec)
      models = spec.dig 'components', 'schemas'
      models.map { |(_name, model)| Model.new(model) }
    end
  end
end
