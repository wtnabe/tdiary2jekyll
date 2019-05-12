require_relative './section_base'
require 'hikidoc'
require 'kramdown'

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
    Kramdown::Document.new(HikiDoc.to_html(body), input: 'html').to_kramdown
  end

  #
  # [return] String
  #
  def ext
    'md'
  end
end
