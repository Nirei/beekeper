# frozen_string_literal: true

require 'openapi/schema/schema'

module Apiculturist
  class Integer < Schema
    def initialize(data)
      super(data)
      @format = data['format'] || IntegerFormat::NONE
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

  module IntegerFormat
    NONE = 'none'
    INT32 = 'int32'
    INT64 = 'int64'
  end
end
