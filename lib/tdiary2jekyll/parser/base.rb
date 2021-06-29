module Tdiary2jekyll
  module Parser
    class Base
      #
      # @param blocks [Array]
      # @param klass [Class]
      # @return [Array]
      #
      def self.generate_section(blocks, klass)
        blocks.map.with_index {|section, index| klass.new(section, index + 1)}
      end
    end
  end
end
