# frozen_string_literal: true

require 'templating/filesystem/folder'
require 'templating/sorbet_rails/model_serializer'

module Apiculturist
  class TemplatingEngine
    def initialize(config)
      @output_path = config['output-path']
      @module_name = config['module-name']
      # TODO: Dinamically pick the appropriate serializer from configuration values
      @model_serializer = SorbetRails::ModelSerializer.new(module_name)
    end

    def codify(spec)
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
    attr_reader :model_serializer
  end
end
