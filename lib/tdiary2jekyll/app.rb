module Tdiary2jekyll
  class App
    #
    # [param] String src
    # [param] String dest
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
    # [param]  TD2Entry entry
    # [return] Constant
    #
    def self.parser(entry)
      Parser.const_get(entry.metadata['Format'].capitalize + 'Format')
    end
  end
end
