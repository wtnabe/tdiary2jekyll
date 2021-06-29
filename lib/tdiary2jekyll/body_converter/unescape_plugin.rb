module Tdiary2jekyll
  module BodyConverter
    class UnescapePlugin
      #
      # @param str [String]
      # @param available [Boolish]
      # @return [String]
      #
      # :reek:BooleanParameter, :reek:ControlParameter
      def self.convert(str, available = true)
        str.gsub(/<span[\s]+class="plugin">(\\\{\\\{[[:alnum:]]+[\s]+\\'.+?(?!}}).+?\\'}})<\/span>/m) do
          if available
            CGI.unescapeHTML($1).gsub(/\\/, '').gsub(/{{/, '{% ').gsub(/}}/, ' %}')
          else
            ''
          end
        end
      end
    end
  end
end
