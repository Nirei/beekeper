# frozen_string_literal: true

module Beekeeper
  # See https://spec.openapis.org/oas/latest.html#schema-object
  # See https://datatracker.ietf.org/doc/html/draft-bhutton-json-schema-00
  class Schema
    def initialize(data, required)
      @description = data['description']
      @deprecated = data['deprecated'] || false
      @visibility = Visibility.from_flags(data['readOnly'], data['writeOnly'])
      @required = required
    end

    attr_reader :description
    attr_reader :deprecated
    attr_reader :visibility
    attr_reader :required
    alias_method :required?, :required

    module Visibility
      READ_WRITE = :read_write
      READ_ONLY = :read_only
      WRITE_ONLY = :write_only

      ERROR_INCONSISTENT_FLAGS = 'inconsistent visibility flags, cannot be both read only and write only at the same time'

      def self.from_flags(read_only, write_only)
        raise ERROR_INCONSISTENT_FLAGS if read_only && write_only
        return READ_ONLY if read_only
        return WRITE_ONLY if write_only

        READ_WRITE
      end
    end
  end
end
