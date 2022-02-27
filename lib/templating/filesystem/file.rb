# frozen_string_literal: true

require 'templating/filesystem/node'

module Beekeeper
  module Filesystem
    # File node inside a filesystem
    class File < Node
      def initialize(parent, name)
        super(parent, name)
        @lines = []
      end

      attr_reader :lines

      def line(input = '')
        lines.push(input.to_s)
      end

      def write!
        ::File.open(path, 'w') do |f|
          lines.each { |line| f.puts(line) }
        end
      end
    end
  end
end
