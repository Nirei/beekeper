# frozen_string_literal: true

require 'openapi/schema/schema'

module Apiculturist
  class Boolean < Schema
    def initialize(data, required)
      super(data)
      @required = required
      @default = data['default']
    end

    attr_reader :required
    alias_method :required?, :required
  end
end
