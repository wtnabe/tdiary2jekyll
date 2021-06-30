require 'spec_helper'

describe Tdiary2jekyll::Writer do
  include DummyData

  let(:writer)  { Tdiary2jekyll::Writer.new(File.dirname(__FILE__) + '/out') }

  describe 'Wiki Format' do
    let(:section) {
      e = Tdiary2jekyll::Structure::Entry.new(DummyData.wiki_format_entry)
      s = Tdiary2jekyll::Parser::WikiFormat.split_to_sections(e.body).first
      s.metadata = Tdiary2jekyll::MetadataConverter::Metadata.convert(e)
      s
    }

    describe '#dest' do
      it {
        assert { writer.dest(section) == File.dirname(__FILE__) + '/out/2002/1229/01.md' }
      }
    end
  end

  describe 'tDiary Format' do
    let(:section) {
      e = Tdiary2jekyll::Structure::Entry.new(DummyData.tdiary_format_entry)
      s = Tdiary2jekyll::Parser::TdiaryFormat.split_to_sections(e.body).first
      s.metadata = Tdiary2jekyll::MetadataConverter::Metadata.convert(e)
      s
    }

    describe '#dest' do
      it {
        assert { writer.dest(section) == File.dirname(__FILE__) + '/out/2004/0622/01.html' }
      }
    end
  end
end
