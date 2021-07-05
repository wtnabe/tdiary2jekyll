require 'hikidoc'

require_relative './base'

module Tdiary2jekyll
  module Section
    class Wiki < Base
      #
      # strip title level heading markup from wiki-style
      #
      # @param line [String]
      # @return [String]
      #
      # :reek:UtilityFunction
      def prepare_first_line(line)
        line.sub(/^! */, '')
      end

      #
      # @param title [String]
      # @return [Array]
      #
      # :reek:UtilityFunction
      def parse_title(title)
        title =~ / *((?:\[[^\[\]]+\])*)(.+)/

        [$1, $2]
      end

      #
      # @param title [String]
      # @return [String]
      #
      def strip_markup_from_title(title)
        super(HikiDoc.to_html(title, { use_wiki_name: false }))
      end

      #
      # @return [String]
      #
      def converted
        Parser::WikiFormat.convert(body)
      end

      #
      # @return [String]
      #
      def ext
        'md'
      end
    end
  end
end
