# frozen_string_literal: true

require 'templating/formatter'
require 'templating/sorbet_rails/constants'
require 'templating/sorbet_rails/schema_serializer'
require 'templating/sorbet_rails/type_mapper'

module Beekeeper
  module SorbetRails
    # In charge of transforming parsed tags, paths and operations into serialized controllers
    class ControllerSerializer
      def initialize(header, module_name)
        @header = header
        @module_name = module_name
        @super_class = 'ApplicationController' # TODO: Allow customization
      end

      def serialize(tag, operations)
        controller = serialize_controller(tag, operations)

        [
          Constants::SORBET_TYPED_STRICT_HINT,
          Constants::FROZEN_STRICT_LITERAL_HINT,
          '',
          header,
          '',
          "module #{module_name}",
          Formatter.indent(controller),
          'end'
        ].flatten
      end

      private

      def serialize_controller(tag, operations)
        [
          Formatter.comment("Abstract API controller for the paths tagged #{tag}"),
          "class #{Formatter.controller_name tag} < #{super_class}",
          Formatter.indent(serialize_body(operations)),
          'end'
        ].flatten
      end

      def serialize_body(operations)
        methods = operations.map { |operation| serialize_operation(operation) }
        method_lines = Formatter.separate(methods).flatten

        [
          Constants::SORBET_EXTEND_T_SIG,
          Constants::SORBET_EXTEND_T_HELPERS,
          'abstract!',
          '',
          method_lines
        ].flatten
      end

      def serialize_operation(operation)
        parameter_signatures = serialize_parameter_signatures(operation.parameters)
        parameter_arguments = serialize_parameter_arguments(operation.parameters)

        # XXX: Missing path parameters!!!
        code = []
        code.push Formatter.comment operation.description unless operation.description.nil?
        code.push("sig { abstract.#{parameter_signatures}void }")
        code.push("def #{Formatter.snake_case operation.operation_id}#{parameter_arguments}; end")
        code
      end

      def serialize_parameter_signatures(parameters)
        return '' if parameters.empty?

        serialized = parameters.map do |name, parameter|
          "#{Formatter.snake_case name}: #{TypeMapper.to_sorbet parameter.schema}"
        end

        "params(#{serialized.join(', ')})."
      end

      def serialize_parameter_arguments(parameters)
        return '' if parameters.empty?

        serialized = parameters.map do |name, parameter|
          Formatter.snake_case name
        end

        "(#{serialized.join(', ')})"
      end

      attr_reader :header
      attr_reader :module_name
      attr_reader :super_class
    end
  end
end
