module Tdiary2jekyll
  module BodyConverter
    class UnescapePluginBlockHtml
      #
      # @param str [String]
      # @param available [Boolish]
      # @return [String]
      #
      # :reek:BooleanParameter, :reek:UnusedParameters
      def self.convert(str, available = true)
        str.gsub(/<div[\s]+class="plugin">\n?{{'(.+?(?!}}).+?)'}}\n?<\/div>/m) do
          CGI.unescapeHTML($1)
        end
      end
    end
  end
end
