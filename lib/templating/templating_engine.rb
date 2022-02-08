# frozen_string_literal: true

require 'time'
require 'templating/formatter'
require 'templating/filesystem/folder'
require 'templating/sorbet_rails/model_serializer'

module Beekeeper
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
        fs.folder 'models' do |fs|
          spec.models.map do |model|
            fs.file "#{Formatter.snake_case model.title}.rb" do |fs|
              model_serializer.serialize(model).each do |content|
                fs.line content
              end
            end
          end
        end
        fs.folder 'controllers' do |fs|
          # TODO: Create controller files
        end
        fs.folder 'config' do |fs|
          fs.file 'routes.rb' do |fs|
            fs.line '# TODO: Add rails routes file content'
          end
        end
      end
    end

    private

    attr_reader :output_path
    attr_reader :module_name
  end
end
