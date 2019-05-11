require 'spec_helper'

describe WikiSection do
  include DummyData

  let(:section) { WikiSection.new(DummyData.one_wiki_section) }

  describe 'title' do
    describe 'start not exclamation mark' do
      it {
        assert { section.title[0] != '!' }
      }
    end
  end
end

