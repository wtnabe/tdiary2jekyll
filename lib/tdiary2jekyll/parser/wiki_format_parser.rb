class WikiFormatParser
  #
  # [param]  String entry
  # [return] Array of WikiSection
  #
  def self.split_to_sections(entry)
    wedged = entry.sub(/^\!/m, "\v!")
    wedged.split(/\v/m).select {|section|
      section.chomp.size > 0
    }.map {|section|
      WikiSection.new(section)
    }
  end
end
