# frozen_string_literal: true

require 'time'
require 'templating/formatter'
require 'templating/filesystem/folder'
require 'templating/sorbet_rails/model_serializer'

module Beekeeper
  # In charge of transforming the OpenAPI spec to code
  class TemplatingEngine
    def initialize(config)
      @output_path = config['output-path']
      @module_name = config['module-name']
    end

    def codify(spec)
      # Create file header comment
      header = Formatter.file_header(spec.title, spec.version, Time.now.utc.iso8601)

      # TODO: Dinamically pick the appropriate serializer from configuration values
      model_serializer = SorbetRails::ModelSerializer.new(header, module_name)

      Filesystem::Folder.root(output_path) do |fs|
        fs.folder 'models' do |models_folder|
          spec.models.map do |model|
            models_folder.file "#{Formatter.snake_case model.title}.rb" do |file|
              model_serializer.serialize(model).each do |content|
                file.line content
              end
            end
          end
        end
        fs.folder 'api' do |api_folder|
          # TODO: Generate controllers
        end
        fs.folder 'config' do |config_folder|
          config_folder.file 'routes.rb' do |routes_file|
            routes_file.line '# TODO: Add rails routes file content'
          end
        end
      end
    end

    private

    attr_reader :output_path
    attr_reader :module_name
  end
end
