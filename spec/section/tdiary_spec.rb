require 'spec_helper'

describe Tdiary2jekyll::Section::Tdiary do
  let(:section) {
    e = Tdiary2jekyll::Structure::Entry.new(DummyData.tdiary_format_entry)
    s = Tdiary2jekyll::Parser::TdiaryFormat.split_to_sections(e.body).first
    s.metadata = Tdiary2jekyll::MetadataConverter::Metadata.convert(e)
    s
  }

  describe '#converted' do
    it 'pass through' do
      assert { section.converted == section.body }
    end
  end

  describe '#ext' do
    it {
      assert { section.ext == 'html' }
    }
  end
end
