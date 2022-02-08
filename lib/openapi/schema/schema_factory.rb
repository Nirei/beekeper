# frozen_string_literal: true

require 'openapi/schema/array'
require 'openapi/schema/boolean'
require 'openapi/schema/integer'
require 'openapi/schema/null'
require 'openapi/schema/number'
require 'openapi/schema/object'
require 'openapi/schema/string'

module Beekeeper
  module SchemaFactory
    # This is a factory method that returns the appropriate Schema instance from the parsed data
    def self.parse(data, required = false)
      case data['type']
      when Type::ARRAY then Beekeeper::Array.new(data, required)
      when Type::BOOLEAN then Beekeeper::Boolean.new(data, required)
      when Type::INTEGER then Beekeeper::Integer.new(data, required)
      when Type::NULL then Beekeeper::Null.new(data, required)
      when Type::NUMBER then Beekeeper::Number.new(data, required)
      when Type::OBJECT then Beekeeper::Object.new(data, required)
      when Type::STRING then Beekeeper::String.new(data, required)
      else raise "unknown type #{type}"
      end
    end

    module Type
      ARRAY = 'array'
      BOOLEAN = 'boolean'
      INTEGER = 'integer'
      NULL = 'null'
      NUMBER = 'number'
      OBJECT = 'object'
      STRING = 'string'
    end
  end
end
