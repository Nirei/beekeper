# frozen_string_literal: true

require 'openapi/schema/schema'
require 'openapi/schema/schema_factory'

module Beekeeper
  class Array < Schema
    def initialize(data, required)
      super(data, required)
      @unique_items = data['uniqueItems']
      @min_items = data['minItems']
      @max_items = data['maxItems']
      @items = SchemaFactory.parse(data['items'])
    end

    attr_reader :unique_items
    attr_reader :min_items
    attr_reader :max_items
    attr_reader :items
  end
end
