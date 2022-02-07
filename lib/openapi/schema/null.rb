# frozen_string_literal: true

require 'openapi/schema/schema'

module Apiculturist
  class Null < Schema
    def initialize(data)
      super(data)
    end
  end
end
