module Tdiary2jekyll
  module MetadataConverter
    class Metadata
      #
      # @param entry [Structure::Entry]
      # @return [Metadata]
      #
      # :reek:NestedIterator
      def self.convert(entry)
        format = nil

        new_entry, new_keys, new_values = entry.dup, [], []
        entry.metadata.each_pair { |key, value|
          if key == 'Format'
            format = value
          else
            new_key, new_value = key.dup, value.dup
            converters.each { |converter|
              new_entry, new_key, new_value = MetadataConverter.const_get(converter).convert(new_entry, new_key, new_value)
            }
            new_keys << new_key
            new_values << new_value
          end
        }

        frontmatter = Hash[*new_keys.zip(new_values).flatten]

        Structure::Metadata.new(format: format, frontmatter: frontmatter)
      end

      #
      # @return [Array]
      #
      def self.converters
        MetadataConverter.constants.select { |constant| constant != :Metadata }
      end
    end
  end
end
