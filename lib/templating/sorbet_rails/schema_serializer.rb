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

    # In charge of transforming parsed schemas into serialized form
    class SchemaSerializer
      def initialize(schema_name, schema)
        @schema_name = schema_name
        @schema = schema
        @queue = []
      end

      def serialize
        code = []
        code.push Formatter.comment schema.description unless schema.description.nil?
        code.concat [
          "class #{Formatter.camel_case schema_name} < T::Struct",
          serialize_toplevel,
          'end',
          '',
          queue.map(&:serialize) # Recursive call
        ]
        code.flatten
      end

      private

      attr_reader :schema_name
      attr_reader :schema
      attr_reader :queue

      def serialize_toplevel
        case schema
        when Beekeeper::Object
          Formatter.indent(serialize_object_properties(schema.properties))
        else
          Formatter.indent(serialize_property(schema_name, schema))
        end
      end

      def serialize_array(name, array)
        inner = serialize_property_type name, array.items
        "T::Array[#{inner}]"
      end

      def serialize_object(name, object)
        # Nested objects get pushed to the queue for later serialization into T::Struct
        # The new T::Struct will be named after the property's own name
        inline_name = Formatter.inline_model name
        queue.push(SchemaSerializer.new(inline_name, object))
        Formatter.camel_case inline_name
      end

      def serialize_ref(_name, property)
        # TODO: Support all this stuff I guess
        raise ERROR_REMOTE_FILE unless property.uri.host.nil? || property.uri.host.empty?
        raise ERROR_ANOTHER_FILE unless property.uri.path.nil? || property.uri.path.empty?

        # FIXME: This is in poor taste and relying on too many assumptions
        Pathname.new(property.uri.fragment).split[-1].to_s
      end

      # Iterate over object properties
      def serialize_object_properties(properties)
        lines = properties.map { |name, property| serialize_property(name, property) }
        lines.flatten
      end

      def serialize_property(name, property)
        code = []
        code.push Formatter.comment property.description unless property.description.nil?

        type = serialize_property_type(name, property)
        value = serialize_property_nilable(property, type)

        code.push "const :#{Formatter.snake_case name}, #{value}"
      end

      # From a given property, return its serialized type
      def serialize_property_type(name, property)
        case property
        when Beekeeper::Array then serialize_array(name, property)
        when Beekeeper::Boolean then 'T::Boolean'
        when Beekeeper::Integer then 'Integer'
        when Beekeeper::Null then 'NilClass'
        when Beekeeper::Number then 'Float'
        when Beekeeper::Object then serialize_object(name, property)
        when Beekeeper::Ref then serialize_ref(name, property)
        when Beekeeper::String then 'String'
        else raise "unknown schema class #{property.class}"
        end
      end

      # If the property is not required, wrap it with T.nilable
      def serialize_property_nilable(property, value)
        return value if property.required?

        "T.nilable(#{value})"
      end
    end
  end
end
