require 'hikidoc'
require 'kramdown'

require_relative './base'

class WikiFormatParser < ParserBase
  class AsinParseError < StandardError; end

  #
  # [param]  String entry
  # [return] Array of WikiSection
  #
  def self.split_to_sections(entry_body)
    wedged = entry_body.sub(/^\!/m, "\v!")
    generate_section(
             wedged.split(/\v/m).select {|section| section.chomp.size > 0},
             WikiSection)
  end

  #
  # [param]  String section
  # [return] String
  #
  def self.convert(section_body)
    body = section_body.gsub(/{{'/m, '').gsub(/'}}/m, '')
    body = convert_amazon_plugin(body, false)
    body = escape_liquid_tag(body)

    Kramdown::Document.new(HikiDoc.to_html(body), input: 'html').to_kramdown
  end

  #
  # [param]  String str
  # [param]  Boolean avaiable
  # [return] String
  #
  def self.convert_amazon_plugin(str, avaiable = true)
    str.gsub(/{{(isbn(_image(?:_(?:right|left))?)?) '([0-9a-zA-Z-]+)'(,[^}]+)?}}/m) {
      return '' unless avaiable

      raise AsinParseError if !$1 || !$3

      type = if $2
               'image'
             else
               'text'
             end

      "{% amazon #{type} #{$3} %}"
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
