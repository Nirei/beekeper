# frozen_string_literal: true

require 'openapi/schema/schema'

module Beekeeper
  class Number < Schema
    def initialize(data, required)
      super(data, required)
      @format = data['format'] || NumberFormat::NONE
      @enum = data['enum'].clone || []
      @enum.freeze
      @minimum = data['minimum']
      @maximum = data['maximum']
      @exclusive_minimum = data['exclusiveMinimum']
      @exclusive_maximum = data['exclusiveMaximum']
      @multiple_of = data['multipleOf']
    end

    attr_reader :format
    attr_reader :enum
    attr_reader :minimum
    attr_reader :maximum
    attr_reader :exclusive_minimum
    attr_reader :exclusive_maximum
    attr_reader :multiple_of
  end

  module NumberFormat
    NONE = 'none'
    INT32 = 'float'
    INT64 = 'double'
  end
end
