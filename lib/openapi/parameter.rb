# frozen_string_literal: true

require 'openapi/schema/schema_factory'

module Beekeeper
  # Contains an OpenAPI parameter definition
  class Parameter
    def initialize(data)
      @name = data['name']
      @schema = SchemaFactory.parse(data['schema'])
      @in = data['in']
    end

    # Parameter name
    attr_reader :name
    # Parameter schema
    attr_reader :schema
    # Parameter location (query, path...)
    attr_reader :in
  end
end
