# frozen_string_literal: true

require 'openapi/schema'

module Apiculturist
  class Array < Schema
    def initialize(data)
      super(data)
    end
  end
end
