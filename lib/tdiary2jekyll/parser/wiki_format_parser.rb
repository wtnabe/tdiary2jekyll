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
    Kramdown::Document.new(HikiDoc.to_html(section_body), input: 'html').to_kramdown
  end
end
