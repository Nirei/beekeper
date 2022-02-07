# frozen_string_literal: true

require 'openapi/schema/schema_factory'

module Apiculturist
  # Contains an OpenAPI model definition
  class Model
    def initialize(data)
      @title = data['title']
      @schema = SchemaFactory.parse(data)
    end

    attr_reader :title
    attr_reader :schema
  end
end
