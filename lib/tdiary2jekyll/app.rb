module Tdiary2jekyll
  class App
    #
    # @param src [String]
    # @param dest [String]
    #
    # :reek:TooManyStatementd, :reek:NestedIterators
    def self.run(src, dest)
      writer = Writer.new(dest)

      Structure::Files.new(src).raw_files.each {|file|
        Structure::File.new(file).entries.each {|entry|
          entry    = Structure::Entry.new(entry)
          metadata = MetadataConverter::Metadata.convert(entry)
          parser(entry).split_to_sections(entry.body).each {|section|
            section.metadata = metadata
            writer.write(section)
          }
        }
      }
    end

    #
    # @param entry [Structure::Entry]
    # @return [Constant]
    # @see Structure::Entry
    #
    def self.parser(entry)
      Parser.const_get(entry.metadata['Format'].capitalize + 'Format')
    end
  end
end
