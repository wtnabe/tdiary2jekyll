class ParserBase
  def self.generate_section(blocks, klass)
    blocks.map {|section| klass.new(section)}
  end
end
