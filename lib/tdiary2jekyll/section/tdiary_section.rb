require_relative './section_base'

class TdiarySection < SectionBase
  #
  # [return] String
  #
  def converted
    body
  end

  #
  # [return] String
  #
  def ext
    'html'
  end
end
