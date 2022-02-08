# frozen_string_literal: true

require 'yaml'
require 'openapi/spec'

module Beekeeper
  # Transforms an OpenAPI spec file into an Beekeeper::Spec instance
  module SpecParser
    def self.parse(spec_file_path)
      # TODO: Validate against OpenAPI JSON Schema
      spec = YAML.load_file(spec_file_path)

      Spec.new(spec)
    end
  end
end
