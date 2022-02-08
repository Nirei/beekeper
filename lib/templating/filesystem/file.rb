# frozen_string_literal: true

require 'templating/filesystem/node'

module Apiculturist
  module Filesystem
    class File < Node
      def initialize(parent, name)
        super(parent, name)
        @lines = []
      end

      def line(input = "")
        @lines.push(input.to_s)
      end
    end
  end
end
