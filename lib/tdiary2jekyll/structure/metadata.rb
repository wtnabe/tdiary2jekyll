module Tdiary2jekyll
  module Structure
    class Metadata
      #
      # @param format [String]
      # @param frontmatter [Hash]
      #
      def initialize(frontmatter: , format:)
        @format      = format
        @frontmatter = frontmatter
      end
      attr_reader :format, :frontmatter
    end
  end
end
