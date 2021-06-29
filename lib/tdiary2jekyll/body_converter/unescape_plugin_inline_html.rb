module Tdiary2jekyll
  module BodyConverter
    class UnescapePluginInlineHtml
      #
      # @param str [String]
      # @param available [Boolish]
      # @return [String]
      #
      # :reek:BooleanParameter, :reek:UnusedParameters
      def self.convert(str, available = true)
        str.gsub(/<span[\s]+class="plugin">\\\{\\\{\\'(.+?(?!}}).+?)\\'}}<\/span>/m) do
          CGI.unescapeHTML($1).gsub(/\\"/, '"')
        end
      end
    end
  end
end
