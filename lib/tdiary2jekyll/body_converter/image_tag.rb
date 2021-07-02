module Tdiary2jekyll
  module BodyConverter
    class ImageTag
      #
      # @param body [String]
      # @param metadata [Metadata]
      # @return [String]
      #
      # :reek:TooManyStatements, :reek:BooleanParameter
      def self.convert(body, metadata)
        body.gsub(/\{\{(?:image\(?(?:_(left|right))?) ('?[0-9]+'?), '([^\']*)', nil(?:, (?:nil|(?:\[((?:[0-9,"%]+|nil),(?:[0-9,"%]+|nil))\])))?(?: \))?\}\}/m) do
          align = $1 if $1
          number = $2.tr('\'', '')
          alt = $3
          
          "{{'<img alt=\"#{alt}\" src=\"/assets/images/diary/#{path(metadata.frontmatter['date'], number)}\"#{align(align)}>'}}"
        end
      end

      #
      # @param date [Date]
      # @param number [Number]
      # @return [String]
      #
      def self.path(date, number)
        year, month, day = date.year, date.month, date.day

        dirname = sprintf("%04d/%02d%02d", year, month, day)
        basename = "#{sprintf("%04d%02d%02d", year, month, day)}_#{number}"

        %w(jpg jpeg png gif webp).map {|ext| [ext, ext.upcase]}.flatten.map {|ext|
          "#{basename}.#{ext}"
        }.select {|filename|
          File.exist?(File.join($IMAGE_DIR, filename))
        }.first
      end

      #
      # @param align [String]
      # @return [String]
      #
      def self.align(align = nil)
        if align
          " align=\"#{align}\""
        else
          nil
        end
      end
    end
  end
end
