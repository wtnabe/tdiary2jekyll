class TDiarySection
  #
  # [param] String section
  #
  def initialize(section)
    @title = nil
    @body  = nil
  end
  attr_reader :title, :body
end
