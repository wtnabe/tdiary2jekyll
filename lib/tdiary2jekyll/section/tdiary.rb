require_relative './base'

module Tdiary2jekyll
  module Section
    class Tdiary < Base
      #
      # [return] String
      #
      def converted
        body
      end

      #
      # [return] String
      #
      def ext
        'html'
      end
    end
  end
end
