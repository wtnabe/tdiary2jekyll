module Tdiary2jekyll
  module MetadataConverter
    class LastModified
      #
      # @param entry [Structure::Entry]
      # @param key [String]
      # @param value [String]
      # @return [Array]
      #
      def self.convert(*args)
        entry, key, value = args

        if key =~ /\A[Ll]ast-[Mm]odified\z/
          [entry, key, Time.at(value.to_i)]
        else
          [entry, key, value]
        end
      end
    end
  end
end
