class TD2Entry
  class CannotParseEntry < StandardError; end

  #
  # [param] String raw
  #
  def initialize(raw)
    @raw      = raw
    @metadata = nil
    @body     = nil

    parse
  end
  attr_reader :raw, :metadata, :body

  def inspect
    "\#<#{self.class}:#{self.object_id} @metadata=#{metadata} @body=\"#{inspected_body}\">"
  end

  #
  # [return] String
  #
  def inspected_body
    if body.size > 200
      body[0,200] + '...'
    else
      body
    end
  end

  def parse
    metadata, body = raw.split(/\n\n/, 2)

    if metadata && body
      parse_metadata(metadata)
      @body = body
    else
      raise CannotParseEntry.new(raw)
    end
  end

  #
  # [param]  String
  # [return] Hash
  #
  def parse_metadata(metadata)
    @metadata = Hash[*metadata.lines.map(&:chomp).map {|line| line.split(/: /, -1)}.flatten]
  end
end
