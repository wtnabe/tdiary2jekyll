# -*- coding: utf-8 -*-
require 'nokogiri'

module Tdiary2jekyll
  module Section
    class Base
      #
      # @param content [String]
      # @param number [Integer]
      # @param metadata [Structure::Metadata]
      #
      def initialize(content = nil, number = nil, metadata = nil)
        @number      = number
        @format      = nil
        @frontmatter = nil
        @title       = nil
        @body        = nil
        @tags        = []
        @metadata    = metadata

        split!(content) if content
        self.metadata = metadata if metadata
      end
      attr_reader :number, :title, :body, :tags, :frontmatter, :format

      #
      # insert Entry Metadata
      #
      # but title is ignored ( overwritten by content title )
      #
      # @param metadata [Structure::Metadata]
      #
      def metadata=(metadata)
        frontmatter = metadata.frontmatter
        frontmatter.merge!('title' => title) if !title.nil?
        frontmatter.merge!('tags' => tags)

        @frontmatter = frontmatter
        @format      = metadata.format
      end

      #
      # @param content [String]
      #
      def split!(content)
        lines = content.lines

        title = prepare_first_line(lines.first)
        parsed_title = split_and_store_title_and_categories!(title)
        @body = lines[1..-1].join.lstrip
      end

      #
      # @param line [String]
      # @return [String]
      #
      def prepare_first_line(line)
        line.strip
      end

      #
      # @param title [String]
      # @return [Array]
      #
      # :reek:UtilityFunction
      def parse_title(title)
        title =~ / *((?:\[[^\]]+\])*)(.+)/

        [$1, $2]
      end

      #
      # @param categories [String]
      # @return [Array]
      #
      def categories_to_a(categories)
        if categories
          "]#{categories}[".split(/\] *\[/).select {|e| e.strip.size > 0}
        else
          []
        end
      end

      #
      # @param title [String]
      # @return [String]
      #
      def strip_markup_from_title(title)
        doc = Nokogiri("<div>#{title}</div>")
        doc.inner_text.strip.gsub(/&/, '&amp;').gsub(/</, '&lt;').gsub(/>/, '&gt;')
      end

      #
      # @param title [String]
      # @return [String]
      #
      # :reek:TooManyStatemanet
      def split_and_store_title_and_categories!(title)
        categories, parsed_title = parse_title(title)

        @tags = categories_to_a(categories)
        @title = strip_markup_from_title(parsed_title)

        parsed_title
      end
    end
  end
end
