require_relative './base'

class TdiaryFormatParser < ParserBase
  #
  # [param]  String entry
  # [return] Array of TDiarySection
  #
  def self.split_to_sections(entry)
    generate_section(entry.split(/\n\n/), TdiarySection)
  end
end
