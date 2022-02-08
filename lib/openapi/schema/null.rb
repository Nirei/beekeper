# frozen_string_literal: true

require 'openapi/schema/schema'

module Beekeeper
  class Null < Schema
    def initialize(data, required)
      super(data, required)
    end
  end
end
