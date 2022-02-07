# frozen_string_literal: true

require 'openapi/schema/schema'
require 'openapi/schema/schema_factory'

module Apiculturist
  class Object < Schema
    def initialize(data)
      super(data)
      @properties = parse_properties(data['properties'])
      @properties.freeze
      @required = data['required'] || []
      @additional_properties = data['additionalProperties'] || false
      @min_properties = data['minProperties']
      @max_properties = data['maxProperties']
    end

    attr_reader :properties
    attr_reader :required
    attr_reader :additional_properties

    private

    def parse_properties(properties)
      properties ||= {}
      properties.map { |key, value| [key, SchemaFactory.parse(value)] }
    end
  end
end
