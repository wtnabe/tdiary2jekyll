class TD2Entry
  #
  # [param] String raw
  #
  def initialize(raw)
    @raw      = raw
    @metadata = nil
    @body     = nil
  end
  attr_reader :raw, :metadata, :body
end
