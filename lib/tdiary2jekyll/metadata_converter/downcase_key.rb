module Tdiary2jekyll
  module MetadataConverter
    class DowncaseKey
      #
      # @param entry [Structure::Entry]
      # @param key [String]
      # @param value [String]
      # @return [Array]
      #
      def self.convert(*args)
        entry, key, value = args

        [entry, key.downcase, value]
      end
    end
  end
end
