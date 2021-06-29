require 'hikidoc'

require_relative './base'

module Tdiary2jekyll
  module Section
    class Wiki < Base
      #
      # strip title level heading markup from wiki-style
      #
      # [param]  String line
      # [return] String
      #
      # :reek:UtilityFunction
      def prepare_first_line(line)
        line.sub(/^! */, '')
      end

      #
      # [param]  String title
      # [return] String
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
      # @param title [String]
      # @param body_lines [String]
      #
      # :reek:UtilityFunction
      def reprepend_title(title, body_lines)
        ["!#{title}", body_lines].join("\n")
      end

      #
      # [return] String
      #
      def converted
        Parser::WikiFormat.convert(body)
      end

      #
      # [return] String
      #
      def ext
        'md'
      end
    end
  end
end
