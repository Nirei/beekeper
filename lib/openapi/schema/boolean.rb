# frozen_string_literal: true

require 'openapi/schema/schema'

module Apiculturist
  class Boolean < Schema
    def initialize(data)
      super(data)
      @default = data['default']
    end
  end
end
