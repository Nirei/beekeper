# frozen_string_literal: true

require 'openapi/schema/schema'

module Beekeeper
  # Boolean type from the OpenAPI spec
  class Boolean < Schema
    def initialize(data, required)
      super(data, required)
      @default = data['default']
    end
  end
end
