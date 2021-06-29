require_relative './base'

module Tdiary2jekyll
  module Section
    class Tdiary < Base
      #
      # @param title [String]
      # @param body_lines [String]
      #
      def reprepend_title(title, body_lines)
        ["<h1>#{title}</h1>", body_lines].join("\n")
      end

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
