# frozen_string_literal: true

module Apiculturist
  # Represents an OpenAPI spec
  class Spec
    def initialize(operations, models)
      @operations = operations
      @models = models
    end

    attr_reader :operations
    attr_reader :models
  end
end
