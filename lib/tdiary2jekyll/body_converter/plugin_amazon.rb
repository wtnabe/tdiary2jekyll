module Tdiary2jekyll
  module BodyConverter
    class PluginAmazon
      #
      # @param body [String]
      # @param available [Boolish]
      # @return [String]
      #
      # :reek:TooManyStatements, :reek:BooleanParameter
      def self.convert(body, avaiable = false)
        body.gsub(/{{(isbn(_image(?:_(?:right|left))?)?) '([0-9a-zA-Z-]+)'(,[^}]+)?}}/m) {
          unless avaiable
            ''
          else

            raise AsinParseError if !$1 || !$3

            type = if $2
                     'image'
                   else
                     'text'
                   end

            "{% amazon #{type} #{$3} %}"
          end
        }
      end
    end
  end
end
