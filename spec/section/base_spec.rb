require 'spec_helper'

describe Tdiary2jekyll::Section::Base do
  include DummyData

  let(:section) { Tdiary2jekyll::Section::Base.new(DummyData.one_wiki_section) }

  describe '#number' do
    describe 'no number given' do
      it {
        assert { section.number == nil }
      }
    end
    describe '2 given' do
      before { @section = Tdiary2jekyll::Section::Base.new(DummyData.one_wiki_section, 2) }
      it     {
        assert { @section.number == 2 }
      }
    end
  end

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

  describe 'title' do
    describe 'not include newline' do
      it {
        assert { !section.title.include?("\n") }
      }
    end
  end

  describe '#split_and_store_title_and_categories!' do
    before { @section = Tdiary2jekyll::Section::Base.new }

    describe 'no title and no categories' do
      before { @section.split_and_store_title_and_categories!('') }

      it 'title empty, too' do
        assert { @section.title == '' }
      end
      it 'zero size categories' do
        assert { @section.categories == [] }
      end
    end

    describe 'title only' do
      before { @section.split_and_store_title_and_categories!('title') }

      it 'title pass through' do
        assert { @section.title      == 'title' }
      end
      it 'categories size zero' do
        assert { @section.categories == [] }
      end
    end

    describe 'title and categories' do
      before { @section.split_and_store_title_and_categories!('[cat1][cat2] title') }

      it 'title not include square brackets' do
        assert { %w([ ]).all? {|b| !@section.title.include?(b)} }
      end
      it 'categories have Array' do
        assert { @section.categories == %w(cat1 cat2) }
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

  describe '#metadata=' do
    describe 'set after initialize' do
      before {
        @section = Tdiary2jekyll::Section::Wiki.new(DummyData.one_wiki_section)
        @section.metadata = Tdiary2jekyll::Structure::Metadata.new(format: 'wiki', frontmatter: {'title' => ''})
      }

      it {
        assert {
          @section.frontmatter == {'title' => 'title', 'categories' => ['cat1', 'cat2']}
        }
      }
    end

    describe 'set when initialize' do
      before {
        @section = Tdiary2jekyll::Section::Wiki.new(
                               DummyData.one_wiki_section,
                               1,
                               Tdiary2jekyll::Structure::Metadata.new(format: 'wiki', frontmatter: {'title' => ''}))
      }

      it {
        assert {
          @section.frontmatter == {'title' => 'title', 'categories' => ['cat1', 'cat2']}
        }
      }
    end
  end
end
