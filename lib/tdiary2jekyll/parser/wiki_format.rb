require 'hikidoc'
require 'kramdown'
require 'cgi'

require_relative './base'

module Tdiary2jekyll
  module Parser
    class WikiFormat < Base
      class AsinParseError < StandardError; end

      #
      # @param entry_body [String]
      # @return [Array] [Section::Wiki]
      #
      def self.split_to_sections(entry_body)
        wedged = entry_body.gsub(/^\![^!]/m, "\v!")
        generate_section(
          wedged.split(/\v/m).select {|section| section.chomp.size > 0},
          Section::Wiki)
      end

      #
      # [param]  String section
      # [return] String
      #
      # :reek:TooManyStatements
      def self.convert(section_body)
        body = escape_liquid_tag(section_body)
        body = convert_plugins(body)
        body = HikiDoc.to_html(body, { use_wiki_name: false })
        body = Kramdown::Document.new(body, input: 'html').to_kramdown
        body = unescape_plugins(body)

        body
      end

      #
      # @param body [String]
      # @return [String]
      #
      def self.convert_plugins(body)
        BodyConverter.constants.select {|constant|
          constant.to_s =~ /\APlugin(.+)\z/
        }.inject(body) {|new_body, constant|
          BodyConverter.const_get(constant).convert(new_body)
        }
      end

      #
      # [param]  String kramdown
      # [return] String
      #
      # :reek:DuplicateMethodCall, :reek:TooManyStatements
      def self.unescape_plugins(kramdown)
        BodyConverter.constants.select {|constant|
          constant.to_s =~ /\AUnescapePlugin(.+)\z/
        }.inject(kramdown) {|new_kramdown, constant|
          BodyConverter.const_get(constant).convert(new_kramdown)
        }
      end

      #
      # [param]  String str
      # [return] String
      #
      def self.escape_liquid_tag(str)
        str.gsub(/{%/m, '&#123;%').gsub(/%}/, '%&#125;')
      end
    end
  end
end
