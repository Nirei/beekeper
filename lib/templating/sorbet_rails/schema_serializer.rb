# frozen_string_literal: true

require 'pathname'
require 'openapi/schema/array'
require 'openapi/schema/boolean'
require 'openapi/schema/integer'
require 'openapi/schema/null'
require 'openapi/schema/number'
require 'openapi/schema/object'
require 'openapi/schema/string'

module Beekeeper
  module SorbetRails
    ERROR_REMOTE_FILE = 'references to remote files are not currently supported'
    ERROR_ANOTHER_FILE = 'references to different files are not currently supported'

    class SchemaSerializer
      def initialize(name, schema)
        @name = name
        @schema = schema
        @queue = []
      end

      def serialize
        case schema
        when Beekeeper::Array then serialize_array
        when Beekeeper::Boolean then "T::Boolean"
        when Beekeeper::Integer then "Integer"
        when Beekeeper::Null then "NilClass"
        when Beekeeper::Number then "Float"
        when Beekeeper::Object then serialize_object
        when Beekeeper::Ref then serialize_ref
        when Beekeeper::String then "String"
        else raise "unknown schema class #{schema.class}"
        end
      end

      private

      attr_reader :name
      attr_reader :schema
      attr_reader :queue

      def serialize_array
        # TODO: Handle type of the array
        "T::Array[T.untyped]"
      end

      def serialize_object
        code = []
        code.push "# #{schema.description}" unless schema.description.nil?
        
        code.concat [
          "class #{Formatter.camel_case name} < T::Struct",
          Formatter.indent(serialize_object_properties schema.properties),
          "end",
          "",
          queue.map(&:serialize)
        ]
        code.flatten
      end

      def serialize_ref
        # TODO: Support all this stuff I guess
        raise ERROR_REMOTE_FILE unless schema.uri.host.nil? || schema.uri.host.empty?
        raise ERROR_ANOTHER_FILE unless schema.uri.path.nil? || schema.uri.path.empty?

        # FIXME: This is in poor taste and relying on too many assumptions
        model_name = Pathname.new(schema.uri.fragment).split[-1].to_s
      end

      # Iterate over object properties
      def serialize_object_properties(properties)
        lines = properties.map { |name, property| serialize_property(name, property) }
        lines.flatten
      end

      def serialize_property(name, property)
          code = []
          code.push "# #{property.description}" unless property.description.nil?
          
          case property
          when Beekeeper::Object
            # Nested objects get pushed to the queue for later serialization into T::Struct
            # The new T::Struct will be named after the property
            inline_name = Formatter.inline_model name
            queue.push(SchemaSerializer.new(inline_name, property))
            value = Formatter.camel_case inline_name
          else
            value = SchemaSerializer.new(name, property).serialize
          end

          code.push "const :#{Formatter.snake_case name}, #{serialize_nilable property, value}"
      end

      # If the property is not required, wrap it with T.nilable
      def serialize_nilable(property, value)
        return value if property.required?
        "T.nilable(#{value})"
      end

    end
  end
end
