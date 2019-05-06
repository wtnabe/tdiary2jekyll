require 'date'

class TD2Entry
  class CannotParseEntry < StandardError; end
  class CannotParseDate  < StandardError; end

  #
  # [param] String raw
  #
  def initialize(raw)
    @raw      = raw
    @date     = nil
    @metadata = nil
    @body     = nil

    parse
  end
  attr_reader :raw, :date, :metadata, :body

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

    parse_date(@metadata['Date']) if @metadata['Date']
  end

  #
  # [param] String date
  #
  def parse_date(date)
    if date =~ /\A([0-9]{4})([0-9]{2})([0-9]{2})\z/
      @date = ::Date.new($1.to_i, $2.to_i, $3.to_i)
    else
      raise CannotParseDate.new(date)
    end
  end
end
