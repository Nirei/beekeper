# frozen_string_literal: true

require 'templating/formatter'
require 'templating/sorbet_rails/constants'
require 'templating/sorbet_rails/schema_serializer'

module Beekeeper
  module SorbetRails
    # In charge of transforming parsed models into serialized form
    class ModelSerializer
      def initialize(header, module_name)
        @header = header
        @module_name = module_name
      end

      def serialize(model)
        schema_serializer = SchemaSerializer.new(model.title, model.schema)
        [
          Constants::SORBET_TYPED_STRICT_HINT,
          '',
          header,
          '',
          "module #{module_name}",
          Formatter.indent(schema_serializer.serialize),
          'end'
        ].flatten
      end

      private

      attr_reader :header
      attr_reader :module_name
    end
  end
end
