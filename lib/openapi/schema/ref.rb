# frozen_string_literal: true

require 'uri'
require 'openapi/schema/schema'
require 'openapi/schema/schema_factory'

module Beekeeper
  class Ref < Schema
    def initialize(data, required)
      super(data, required)
      @uri = URI.parse(data['$ref']).freeze
    end

    attr_reader :uri
  end
end
