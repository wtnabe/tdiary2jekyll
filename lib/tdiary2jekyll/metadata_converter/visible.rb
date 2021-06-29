module Tdiary2jekyll
  module MetadataConverter
    class Visible
      #
      # @param entity [Structure::Entry]
      # @param key [String]
      # @param value [String]
      # @return [Boolean]
      #
      # :reek:UnusedParameter
      def self.convert(*args)
        entry, key, value = args

        if key =~ /\A[Vv]isible\z/
          [entry, 'published', (value == 'true')]
        else
          [entry, key, value]
        end
      end
    end
  end
end
