# frozen_string_literal: true

require 'openapi/schema/schema'
require 'openapi/schema/schema_factory'

module Beekeeper
  # Array type from the OpenAPI spec
  class Array < Schema
    def initialize(data, required)
      super(data, required)
      @unique_items = data['uniqueItems']
      @min_items = data['minItems']
      @max_items = data['maxItems']
      @items = SchemaFactory.parse(data['items'])
    end

    # Constrain for this array items to be unique
    attr_reader :unique_items
    # Minimum amount of items that this array can hold
    attr_reader :min_items
    # Maximum amount of items that this array can hold
    attr_reader :max_items
    # Schema for the contents of the array
    attr_reader :items
  end
end
