require 'spec_helper'

describe SectionBase do
  include DummyData

  let(:section) { SectionBase.new(DummyData.one_wiki_section) }

  describe 'basic structure' do
    describe 'splitted into title and body' do
      it 'title not empty' do
        assert { section.title.size > 0 }
      end

      it 'body not empty' do
        assert { section.body.size > 0 }
      end
    end
  end

  describe 'body' do
    describe 'start with not blank line' do
      it {
        assert { section.body.lines.first != "\n" }
      }
    end

    describe 'must have newline terminator' do
      it {
        assert { section.body =~ /(.*)\n\z/m }
      }
    end
  end
end
