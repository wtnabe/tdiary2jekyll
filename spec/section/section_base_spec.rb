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
end
