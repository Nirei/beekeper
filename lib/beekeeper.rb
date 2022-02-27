# frozen_string_literal: true

require 'yaml'
require 'generator/generator'

# Main module for the beekeeper gem. Exposes the code generation API.
module Beekeeper
  ERROR_CONFIG_BOTH = 'Either a configuration object or a configuration file path can be specified, but not both'
  ERROR_CONFIG_NONE = 'Please specify generator configuration'

  def self.generate(config: nil, config_file_path: nil)
    raise ERROR_CONFIG_BOTH unless config.nil? || config_file_path.nil?

    raise ERROR_CONFIG_NONE if config.nil? && config_file_path.nil?

    config = parse_config(config_file_path) unless config_file_path.nil?
    generator = Generator.new(config)

    generator.generate
  end

  def self.parse_config(config_file_path)
    # TODO: Create a JSON Schema for the config file, then validate the file against the JSON Schema
    YAML.load_file(config_file_path)
  end
end