class TDiaryFormatParser
  #
  # [param]  String entry
  # [return] Array of TDiarySection
  #
  def self.split_to_sections(entry)
    entry.split(/^$/).map {|section| TDiarySection.new(section)}
  end
end
