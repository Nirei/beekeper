# frozen_string_literal: true

require 'openapi/schema/schema_factory'

module Beekeeper
  # Contains an OpenAPI parameter definition
  class Parameter
    def initialize(data)
      @name = data['name']
      @schema = SchemaFactory.parse(data['schema'])
    end

    attr_reader :name
    attr_reader :schema
  end
end
