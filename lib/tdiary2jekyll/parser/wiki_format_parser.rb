require 'hikidoc'
require 'kramdown'

require_relative './base'

class WikiFormatParser < ParserBase
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

    Kramdown::Document.new(HikiDoc.to_html(body), input: 'html').to_kramdown
  end

  #
  # [param]  String str
  # [return] String
  #
  def self.convert_amazon_plugin(str)
=begin
    text
    image
    small_image
    medium_image
    large_image
    title
    detail
=end
    str.gsub(/{{isbn '([0-9a-z]+)'}}/m, '{% amazon text \1 %}')
  end
end
