require 'fileutils'

module Tdiary2jekyll
  class Writer
    #
    # @param dest [String]
    #
    def initialize(dest)
      @out_dir = dest
    end
    attr_reader :out_dir

    #
    # @param section [Section]
    # @return [String]
    #
    # :reek:FeatureEnvy
    def dest(section)
      date = section.frontmatter['date']

      File.join(
        @out_dir,
        Util.path(date: date, section_number: section.number, section_ext: section.ext))
    end

    #
    # @param section [Section]
    #
    # :reek:TooManyStatements, :reek:UncommunicativeVariable
    def write(section)
      path = dest(section)

      FileUtils.mkdir_p(File.dirname(path))
      File.open(path, 'w') {|f|
        f.puts section.frontmatter.to_yaml
        f.puts '---'
        f.puts section.converted
      }
    end
  end
end
