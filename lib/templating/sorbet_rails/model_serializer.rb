# frozen_string_literal: true

require 'templating/formatter'
require 'templating/sorbet_rails/schema_serializer'

module Apiculturist
  module SorbetRails
    class ModelSerializer
      def initialize(module_name)
        @module_name = module_name
      end
      
      def serialize(model)
        schema_serializer = SchemaSerializer.new(model.title, model.schema)
        [
          "# typed: strict",
          "",
          "module #{Formatter.camel_case module_name}",
          Formatter.indent(schema_serializer.serialize),
          "end"
        ].flatten
      end

      private

      attr_reader :module_name
    end
  end
end
