# frozen_string_literal: true

module Apiculturist
  module Formatter
    def self.snake_case(string)
      string
        .gsub(/::/, '/')
        .gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
        .gsub(/([a-z\d])([A-Z])/,'\1_\2')
        .tr("-", "_")
        .downcase
    end

    def self.camel_case(string)
      string
        .split('_')
        .map{|e| e.capitalize}
        .join
    end

    def self.indent(line_array, depth=1)
      line_array.map {|line| "#{"  " * depth}#{line}"}
    end
  end
end
