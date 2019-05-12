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

  describe '#converted' do
    it {
      assert {
        section.converted == <<EOD
## heading 2-1

body line 1 body line 2

[text][1]

## heading 2-2

body line 3 body line 4



[1]: http://example.com
EOD
      }
    }
  end

  describe '#ext' do
    it {
      assert { section.ext == 'md' }
    }
  end
end

