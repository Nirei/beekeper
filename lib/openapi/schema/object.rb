# frozen_string_literal: true

require 'openapi/schema/schema'
require 'openapi/schema/schema_factory'

module Beekeeper
  class Object < Schema
    def initialize(data, required)
      super(data, required)
      @required_children = data['required'] || []
      @properties = parse_properties(data['properties'])
      @properties.freeze
      @additional_properties = data['additionalProperties'] || false
      @min_properties = data['minProperties']
      @max_properties = data['maxProperties']
    end

    attr_reader :properties
    attr_reader :required_children
    attr_reader :additional_properties

    private

    def parse_properties(properties)
      properties ||= {}
      properties.map { |key, value| [key, SchemaFactory.parse(value, required_children.include?(key))] }
    end
  end
end
