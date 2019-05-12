require 'spec_helper'

describe TdiarySection do
  let(:section) {
    e = TD2Entry.new(DummyData.tdiary_format_entry)
    s = TdiaryFormatParser.split_to_sections(e.body).first
    s.metadata = MetadataConverter.convert(e)
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
