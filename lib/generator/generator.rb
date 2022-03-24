# frozen_string_literal: true

require 'generator/generator_config'
require 'generator/spec_parser'
require 'templating/templating_engine'

module Beekeeper
  # Core class in charge of code generation
  class Generator
    def initialize(config)
      @config = config
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

    def parse_spec
      SpecParser.parse(GeneratorConfig.new(config).spec)
    end

    def create_code(spec)
      TemplatingEngine.new(config, spec).codify
    end

    def write_output(files)
      files.write!
    end
  end
end
