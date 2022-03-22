# frozen_string_literal: true

require 'openapi/model'
require 'openapi/path'

module Beekeeper
  # Represents an OpenAPI spec
  class Spec
    def initialize(spec)
      @openapi_version = (spec['openapi']) || ''
      @title = spec.dig('info', 'title') || ''
      @version = spec.dig('info', 'version') || ''
      @tags = spec['tags'] || []

      @paths = parse_paths(spec)
      @models = parse_models(spec)
    end

    attr_reader :openapi_version
    attr_reader :title
    attr_reader :version

    attr_reader :tags
    attr_reader :paths
    attr_reader :models

    private

    def parse_paths(spec)
      paths = spec['paths'] || []
      paths.map do |path, values|
        Path.new(path, values)
      end
    end

    def parse_models(spec)
      models = spec.dig 'components', 'schemas'
      models ||= []
      # TODO: Append endpoint inline models
      models.map { |(_name, model)| Model.new(model) }
    end
  end
end
