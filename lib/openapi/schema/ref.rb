# frozen_string_literal: true

require 'openapi/schema/schema'
require 'openapi/schema/schema_factory'

module Beekeeper
  class Ref < Schema
    def initialize(data, required)
      super(data, required)
      @path = data['$ref']
    end

    attr_reader :path
  end
end
