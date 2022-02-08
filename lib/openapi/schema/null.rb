# frozen_string_literal: true

require 'openapi/schema/schema'

module Apiculturist
  class Null < Schema
    def initialize(data, required)
      super(data)
      @required = required
    end

    attr_reader :required
    alias_method :required?, :required
  end
end
