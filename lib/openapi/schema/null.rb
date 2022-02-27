# frozen_string_literal: true

require 'openapi/schema/schema'

module Beekeeper
  # Null type from the OpenAPI spec
  class Null < Schema
    def initialize(data, required)
      super(data, required)
    end
  end
end
