class TDiaryFormatParser
  #
  # [param]  String entry
  # [return] Array of TDiarySection
  #
  def self.split_to_sections(entry)
    entry.split(/\n\n/).map {|section| TDiarySection.new(section)}
  end
end
