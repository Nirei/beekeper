# frozen_string_literal: true

require 'yaml'
require 'generator/spec'

module Apiculturist
  # Transforms an OpenAPI spec file into an Apiculturist::Spec instance
  module SpecParser
    def self.parse(spec_file_path)
      # TODO: Validate against OpenAPI JSON Schema
      spec = YAML.load_file(spec_file_path)

      Spec.new(parse_operations(spec), parse_models(spec))
    end

    private

    def self.parse_operations(spec); end

    def self.parse_models(spec)
      models = spec.dig 'components', 'schemas'
      models.map { |model| parse_model(model) }
    end

    def self.parse_model(model)
      puts model.inspect
    end
  end
end
