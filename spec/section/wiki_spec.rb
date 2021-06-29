require 'spec_helper'

describe Tdiary2jekyll::Section::Wiki do
  include DummyData

  let(:section) { Tdiary2jekyll::Section::Wiki.new(DummyData.one_wiki_section) }

  describe 'title' do
    describe 'start not exclamation mark' do
      it {
        assert { section.title[0] != '!' }
      }
    end
  end

  describe '#split_and_store_title_and_categories!' do
    describe 'include link' do
      before { section.split_and_store_title_and_categories!('[Biz][Tool][[職場でのIM利用が増加--2008年までに倍増の予測|http://japan.cnet.com/news/media/story/0,2000047715,20069200,00.htm]]') }
      it {
        assert {
          section.categories == %w(Biz Tool)
        }
      }
      it {
        assert {
          section.title == '職場でのIM利用が増加--2008年までに倍増の予測'
        }
      }
    end
  end

  describe '#converted' do
    it {
      assert {
        section.converted == <<EOD
# title

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
