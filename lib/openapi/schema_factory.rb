# frozen_string_literal: true

require 'openapi/type/array'
require 'openapi/type/boolean'
require 'openapi/type/integer'
require 'openapi/type/number'
require 'openapi/type/object'
require 'openapi/type/string'

module Apiculturist
  module SchemaFactory

    # This is a factory method that returns the appropriate Schema instance from the parsed data
    def self.parse(data)
      case data['type']
      when Type::ARRAY then Apiculturist::Array.new(data)
      when Type::BOOLEAN then Apiculturist::Boolean.new(data)
      when Type::INTEGER then Apiculturist::Integer.new(data)
      when Type::NUMBER then Apiculturist::Number.new(data)
      when Type::OBJECT then Apiculturist::Object.new(data)
      when Type::STRING then Apiculturist::String.new(data)
      else raise Error("unknown type #{type}")
      end
    end

    module Type
      ARRAY = 'array'
      BOOLEAN = 'boolean'
      INTEGER = 'integer'
      NUMBER = 'number'
      OBJECT = 'object'
      STRING = 'string'
    end
  end
end
