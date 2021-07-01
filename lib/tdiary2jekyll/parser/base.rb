module Tdiary2jekyll
  module Parser
    class Base
      #
      # @param blocks [Array]
      # @param klass [Class]
      # @param metadata [Structure::Metadata]
      # @return [Array]
      #
      def self.generate_section(blocks, klass, metadata = nil)
        blocks.map.with_index {|section, index| klass.new(section, index + 1, metadata)}
      end
    end
  end
end
