# frozen_string_literal: true

require 'openapi/schema'

module Apiculturist
  class Integer < Schema
    def initialize(data)
      super(data)
    end
  end
end
