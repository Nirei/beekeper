# frozen_string_literal: true

require 'templating/filesystem/node'

module Beekeeper
  module Filesystem
    # File node inside a filesystem
    class File < Node
      def initialize(parent, name)
        super(parent, name)
        @buffer = []
      end

      attr_reader :buffer

      # Append a line to the file
      def line(input = '')
        buffer.push(input.to_s)
      end

      # Append multiple lines to the file given as an array of strings
      def lines(input)
        buffer.concat(input.map(&:to_s))
      end

      def write!
        ::File.open(path, 'w') do |f|
          buffer.each { |line| f.puts(line) }
        end
      end
    end
  end
end
