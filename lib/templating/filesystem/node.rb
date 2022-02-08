# frozen_string_literal: true

module Apiculturist
  module Filesystem
    class Node
      def initialize(parent, name)
        @parent = parent
        @name = name
      end

      attr_accessor :parent
      attr_reader :name

      def path
        return name if parent.nil?
        return ::File.join(parent.path, name)
      end
    end
  end
end