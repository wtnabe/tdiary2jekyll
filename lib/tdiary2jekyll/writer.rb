require 'fileutils'

class Writer
  #
  # [param] String dest
  #
  def initialize(dest)
    @out_dir = dest
  end
  attr_reader :out_dir

  #
  # [param]  Section section
  # [return] String
  #
  def dest(section)
    date = section.frontmatter['date']

    File.join(@out_dir, sprintf("%04d/%02d/%02d/%02d.#{section.ext}", date.year, date.month, date.day, section.number))
  end

  #
  # [param] Section section
  #
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
