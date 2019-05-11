# -*- coding: utf-8 -*-
class SectionBase
  #
  # [param] String section
  # [param] Metadata metadata
  #
  def initialize(section = nil, metadata = nil)
    @format      = nil
    @frontmatter = nil
    @title       = nil
    @body        = nil
    @categories  = []

    split(section) if section
    self.metadata = metadata if metadata
  end
  attr_reader :title, :body, :categories, :frontmatter, :format

  #
  # [param] Metadata metadata
  #
  def metadata=(metadata)
  end

  #
  # [param] String section
  #
  def split(section)
    lines = section.lines

    title = parse_title(lines.first)
    split_and_store_title_and_categories(title)
    @body  = lines[1..-1].join.lstrip
  end

  #
  # [param]  String title
  # [return] String
  #
  def parse_title(title)
    title.strip
  end

  #
  # [param]  title
  # [return] Array
  #
  def split_and_store_title_and_categories(title)
    title =~ / *((?:\[[^\]]+\])*)(.+)/
    @title      = $2 ? $2.strip : ''
    @categories = if $1
                    "]#{$1}[".split(/\] *\[/).select {|e| e.strip.size > 0}
                  else
                    []
                  end
  end
end
