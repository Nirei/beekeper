# frozen_string_literal: true

require 'openapi/schema/type'

module Beekeeper
  # Maps OpenAPI types into Sorbet types
  module TypeMapper
    def self.to_sorbet(type)
      case type
      when Beekeeper::Array
        'T::Array[?ITEM_TYPE?]'
      when Beekeeper::Boolean
        'T::Boolean'
      when Beekeeper::Integer
        'Integer'
      when Beekeeper::Null
        'NilClass'
      when Beekeeper::Number
        'Float'
      when Beekeeper::Object
        '?STRUCT_NAME/HASH?'
      when Beekeeper::String
        'String'
      end
    end
  end
end
