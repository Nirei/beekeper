# frozen_string_literal: true

require 'time'
require 'templating/formatter'
require 'templating/filesystem/folder'
require 'templating/sorbet_rails/model_serializer'
require 'templating/sorbet_rails/controller_serializer'

module Beekeeper
  # In charge of transforming the OpenAPI spec to code
  class TemplatingEngine
    def initialize(config, spec)
      @output_path = config['output-path']
      @module_name = config['module-name']
      @spec = spec
    end

    def codify
      Filesystem::Folder.root(output_path) do |root_folder|
        create_models root_folder, spec
        create_api root_folder, spec
        create_config root_folder, spec
      end
    end

    private

    attr_reader :output_path
    attr_reader :module_name
    attr_reader :spec

    def model_serializer
      # TODO: Pick the appropriate serializer from configuration values
      @model_serializer ||= SorbetRails::ModelSerializer.new(header, module_name)
    end

    def controller_serializer
      # TODO: Pick the appropriate serializer from configuration values
      @controller_serializer ||= SorbetRails::ControllerSerializer.new(header, module_name)
    end

    # Create file header comment
    def header
      @header ||= Formatter.file_header(spec.title, spec.version, Time.now.utc.iso8601)
    end

    def create_models(root_folder, spec)
      root_folder.folder 'models' do |models_folder|
        spec.models.map do |model|
          models_folder.file "#{Formatter.snake_case model.title}.rb" do |file|
            file.lines model_serializer.serialize(model)
          end
        end
      end
    end

    def create_api(root_folder, spec)
      root_folder.folder 'api' do |api_folder|
        spec.tags.map do |tag|
          tag_operations = spec.paths.flat_map do |path|
            path.operations.select { |_method, operation| operation.tags.first == tag }.values
          end

          next if tag_operations.empty?

          api_folder.file "#{Formatter.snake_case tag}.rb" do |tag_file|
            tag_file.lines controller_serializer.serialize(tag, tag_operations)
          end
        end
      end
    end

    def create_config(root_folder, _spec)
      root_folder.folder 'config' do |config_folder|
        config_folder.file 'routes.rb' do |routes_file|
          routes_file.line '# TODO: Add rails routes file content'
        end
      end
    end
  end
end
