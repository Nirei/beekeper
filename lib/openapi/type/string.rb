# frozen_string_literal: true

require 'openapi/schema'

module Apiculturist
  class String < Schema
    def initialize(data)
      super(data)
      @default = data['default']
      @pattern = data['pattern']
      @min_length = data['minLength']
      @max_length = data['maxLength']
    end

    attr_reader :default
    attr_reader :pattern
    attr_reader :min_length
    attr_reader :max_length
  end

  module StringFormat
    NONE = 'none'
    DATE = 'date'
    TIME = 'time'
    DATE_TIME = 'date-time'
    DURATION = 'duration'
    URI = 'uri'
    URI_REFERENCE = 'uri-reference'
    IRI = 'iri'
    IRI_REFERENCE = 'iri-reference'
    EMAIL = 'email'
    IDN_EMAIL = 'idn-email'
    HOSTNAME = 'hostname'
    IDN_HOSTNAME = 'idn-hostname'
    PASSWORD = 'password'
    IPV4 = 'ipv4'
    IPV6 = 'ipv6'
    UUID = 'uuid'
    BINARY = 'binary'
    BYTE = 'byte'
    JSON_POINTER = 'json-pointer'
    RELATIVE_JSON_POINTER = 'relative-json-pointer'
  end
end
