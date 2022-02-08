# frozen_string_literal: true

require 'generator/generator_config'
require 'generator/spec_parser'
require 'templating/templating_engine'

module Beekeeper
  # Core class in charge of code generation
  class Generator
    def initialize(config)
      @config = GeneratorConfig.new(config)
      @engine = TemplatingEngine.new(config)
    end

    # Implements the information flow that goes from an OpenAPI spec to a series of statically generated Ruby files that
    # use sorbet and sorbet-rails for parsing / validation and providing type safety.
    def generate
      spec = parse_spec
      files = create_code(spec)
      write_output(files)
    end

    private

    attr_reader :config
    attr_reader :engine

    def parse_spec
      SpecParser.parse(config.spec)
    end

    def create_code(spec)
      engine.codify(spec)
    end

    def write_output(files)
      files.write!
    end
  end
end
