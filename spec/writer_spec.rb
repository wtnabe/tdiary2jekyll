require 'spec_helper'

describe Writer do
  include DummyData

  let(:section) {
    e = TD2Entry.new(DummyData.wiki_format_entry)
    s = WikiFormatParser.split_to_sections(e.body).first
    s.metadata = MetadataConverter.convert(e)
    s
  }
  let(:writer)  { Writer.new(File.dirname(__FILE__) + '/out') }

  describe '#dest' do
    it {
      assert { writer.dest(section) == File.dirname(__FILE__) + '/out/2002/12/29/01.md' }
    }
  end
end
