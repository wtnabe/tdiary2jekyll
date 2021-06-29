module Tdiary2jekyll
  module MetadataConverter
    class Date
      #
      # @param entry [Structure::Entry]
      # @param key [String]
      # @param value [String]
      # @return [Array]
      #
      def self.convert(*args)
        entry, key, value = args

        if key =~ /\A[Dd]ate\z/
          [entry, key, entry.date.to_time]
        else
          [entry, key, value]
        end
      end
    end
  end
end
