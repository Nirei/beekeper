# frozen_string_literal: true

require 'openapi/schema/array'
require 'openapi/schema/boolean'
require 'openapi/schema/integer'
require 'openapi/schema/null'
require 'openapi/schema/number'
require 'openapi/schema/object'
require 'openapi/schema/string'

module Apiculturist
  module SorbetRails
    class SchemaSerializer
      def initialize(name, schema)
        @name = name
        @schema = schema
      end

      def serialize
        case schema
        when Apiculturist::Array then serialize_array
        when Apiculturist::Boolean then serialize_boolean
        when Apiculturist::Integer then serialize_integer
        when Apiculturist::Null then serialize_null
        when Apiculturist::Number then serialize_number
        when Apiculturist::Object then serialize_object
        when Apiculturist::String then serialize_string
        else raise "unknown schema class #{schema.class}"
        end
      end

      private

      attr_reader :name
      attr_reader :schema

      def serialize_array
        "T::Array"
      end

      def serialize_boolean
        "T::Boolean"
      end

      def serialize_integer
        "Integer"
      end

      def serialize_null
        "NilClass"
      end

      def serialize_number
        "Float"
      end

      def serialize_object
        [
          "# #{schema.description}",
          "class #{Formatter.camel_case name} < T::Struct",
          Formatter.indent(serialize_object_properties schema.properties),
          "end"
        ].flatten
      end

      def serialize_string
        "String"
      end

      # Iterate over object properties
      def serialize_object_properties(properties)
        lines = properties.map do |name, property|
          [
            "# #{property.description}",
            "const :#{Formatter.snake_case name}, #{serialize_nilable name, property}"
          ]
        end

        lines.flatten
      end

      # If the property is not required, wrap it with T.nilable
      def serialize_nilable(name, property)
        serializer = SchemaSerializer.new(name, property)
        return serializer.serialize if property.required?
        "T.nilable(#{serializer.serialize})"
      end
    end
  end
end
