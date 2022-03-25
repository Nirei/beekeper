# frozen_string_literal: true

require 'openapi/schema/type'
require 'openapi/schema/array'
require 'openapi/schema/boolean'
require 'openapi/schema/integer'
require 'openapi/schema/null'
require 'openapi/schema/number'
require 'openapi/schema/object'
require 'openapi/schema/ref'
require 'openapi/schema/string'

module Beekeeper
  # Factory for Schema subclasses that picks the appropriate class for a schema by reading the OpenAPI type information
  module SchemaFactory
    # This is a factory method that returns the appropriate Schema instance from the parsed data
    def self.parse(data, required: false)
      return Beekeeper::Ref.new(data, required) if ref? data

      type = data['type']
      case type
      when Type::ARRAY then Beekeeper::Array.new(data, required)
      when Type::BOOLEAN then Beekeeper::Boolean.new(data, required)
      when Type::INTEGER then Beekeeper::Integer.new(data, required)
      when Type::NULL then Beekeeper::Null.new(data, required)
      when Type::NUMBER then Beekeeper::Number.new(data, required)
      when Type::OBJECT then Beekeeper::Object.new(data, required)
      when Type::STRING then Beekeeper::String.new(data, required)
      else raise "unknown type `#{type}` in #{data}"
      end
    end

    def self.ref?(data)
      !data['$ref'].nil?
    end

    private_class_method :ref?
  end
end
