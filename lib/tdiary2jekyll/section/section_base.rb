class SectionBase
  #
  # [param] String section
  #
  def initialize(section)
    @title = nil
    @body  = nil

    split(section)
  end
  attr_reader :title, :body

  #
  # [param] String section
  #
  def split(section)
    lines = section.lines

    @title = lines.first
    @body  = lines[1..-1].join.lstrip
  end
end
