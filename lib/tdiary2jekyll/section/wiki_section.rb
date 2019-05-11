require_relative './section_base'

class WikiSection < SectionBase
  #
  # [param]  String title
  # [return] String
  #
  def parse_title(title)
    super.sub(/^! */, '')
  end
end
