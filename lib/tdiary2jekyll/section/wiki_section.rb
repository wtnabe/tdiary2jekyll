require_relative './section_base'

class WikiSection < SectionBase
  #
  # [param]  String title
  # [return] String
  #
  def parse_title(title)
    super.sub(/^! */, '')
  end

  #
  # [return] String
  #
  def converted
    WikiFormatParser.convert(body)
  end

  #
  # [return] String
  #
  def ext
    'md'
  end
end
