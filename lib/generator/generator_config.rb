# frozen_string_literal: true

module Beekeeper
  ERROR_CONFIG_PARSE = 'Error parsing config, mandatory attribute `%<name>s` not found'

  # Data class to contain necessary config for Beekeeper::Generator
  class GeneratorConfig
    def initialize(config)
      @spec = parse_attr(config, 'spec-path')
      @output = parse_attr(config, 'output-path')
    end

    attr_reader :spec
    attr_reader :output

    private

    def parse_attr(config, name)
      raise ERROR_CONFIG_PARSE.format({ name: name }) if config[name].nil?

      config[name]
    end
  end
end
