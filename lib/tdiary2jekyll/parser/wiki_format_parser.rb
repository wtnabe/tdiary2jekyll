require_relative './base'

class WikiFormatParser < ParserBase
  #
  # [param]  String entry
  # [return] Array of WikiSection
  #
  def self.split_to_sections(entry)
    wedged = entry.sub(/^\!/m, "\v!")
    generate_section(
             wedged.split(/\v/m).select {|section| section.chomp.size > 0},
             WikiSection)
  end
end
