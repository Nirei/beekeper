# frozen_string_literal: true

require 'templating/filesystem/node'
require 'templating/filesystem/file'

module Beekeeper
  # The Filesystem module provides a simple DSL for defining relative directory structures containing text files.
  # It can be used as follows
  # ```
  # Filesystem.root "root-folder", do
  #   folder "examples", do
  #
  #     file "example_1.rb", do
  #       line "first line"
  #       line
  #       line "third line"
  #     end
  #     folder "nested"
  #   end
  #
  #   folder "sibling" end
  #     folder "nested"
  #   end
  # end
  # ```
  module Filesystem
    # Folder node inside a filesystem
    class Folder < Node
      def initialize(parent, name)
        super(parent, name)
        @children = []
      end

      attr_reader :children

      # Begins a relative directory structure definition, see `Filesystem`
      def self.root(name)
        root = Folder.new(nil, name)
        yield root
        root
      end

      def add(node)
        raise "illegal argument #{node}" unless node.is_a? Node

        children.push(node)
      end

      def folder(name)
        child = Folder.new(self, name)
        add(child)
        yield child
      end

      def file(name)
        child = File.new(self, name)
        add(child)
        yield child
      end

      def write!
        Dir.mkdir path unless Dir.exist? path
        children.each(&:write!)
      end

      def to_s
        "#<#{self.class.name}:#{path}>"
      end
    end
  end
end
