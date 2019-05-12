require 'spec_helper'

describe Writer do
  include DummyData

  let(:writer)  { Writer.new(File.dirname(__FILE__) + '/out') }

  describe 'Wiki Format' do
    let(:section) {
      e = TD2Entry.new(DummyData.wiki_format_entry)
      s = WikiFormatParser.split_to_sections(e.body).first
      s.metadata = MetadataConverter.convert(e)
      s
    }

    describe '#dest' do
      it {
        assert { writer.dest(section) == File.dirname(__FILE__) + '/out/2002/12/29/01.md' }
      }
    end
  end

  describe 'tDiary Format' do
    let(:section) {
      e = TD2Entry.new(DummyData.tdiary_format_entry)
      s = TdiaryFormatParser.split_to_sections(e.body).first
      s.metadata = MetadataConverter.convert(e)
      s
    }

    describe '#dest' do
      it {
        assert { writer.dest(section) == File.dirname(__FILE__) + '/out/2004/06/22/01.html' }
      }
    end
  end
end
