# frozen_string_literal: true

require 'generator/generator_config'
require 'generator/spec_parser'

module Apiculturist
  # Core class in charge of code generation
  class Generator
    def initialize(config)
      @config = GeneratorConfig.new(config)
    end

    # Implements the information flow that goes from an OpenAPI spec to a series of statically generated Ruby files that
    # use sorbet and sorbet-rails for parsing / validation and providing type safety.
    def generate
      parse_spec
    end

    private

    attr_reader :config

    def parse_spec
      SpecParser.parse(config.spec)
    end

    def create_code; end

    def write_files; end
  end
end
