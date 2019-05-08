module DummyData
  #
  # [return] String
  #
  def wiki_format_entry
    File.read(File.dirname(__FILE__) + '/entry_wiki_20021229.txt')
  end

  def tdiary_format_entry
    File.read(File.dirname(__FILE__) + '/entry_tdiary_20040622.txt')
  end

  module_function :wiki_format_entry, :tdiary_format_entry
end

