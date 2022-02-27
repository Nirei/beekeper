# frozen_string_literal: true

module Beekeeper
  module Filesystem
    # Abstract base class for filesystem nodes
    class Node
      def initialize(parent, name)
        @parent = parent
        @name = name
      end

      attr_accessor :parent
      attr_reader :name

      def path
        return name if parent.nil?

        ::File.join(parent.path, name)
      end
    end
  end
end
