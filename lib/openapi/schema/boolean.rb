# frozen_string_literal: true

require 'openapi/schema/schema'

module Beekeeper
  class Boolean < Schema
    def initialize(data, required)
      super(data, required)
      @default = data['default']
    end
  end
end
