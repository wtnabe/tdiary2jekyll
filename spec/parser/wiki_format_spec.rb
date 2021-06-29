# -*- coding: utf-8 -*-
require 'spec_helper'

require_relative '../support/dummy_data'

describe Tdiary2jekyll::Parser::WikiFormat do
  describe '.split_to_sections' do
    let(:entry) { DummyData.wiki_format_entry }

    describe 'size' do
      it {
        assert {
          Tdiary2jekyll::Parser::WikiFormat.split_to_sections(Tdiary2jekyll::Structure::Entry.new(entry).body).size == 1
        }
      }
    end

    describe 'return WikiSection instances' do
      it {
        assert {
          Tdiary2jekyll::Parser::WikiFormat.split_to_sections(Tdiary2jekyll::Structure::Entry.new(entry).body).all? {|s|
            s.title.chomp.size > 0 && s.body.chomp.size > 0
          }
        }
      }
    end
  end

  describe '.escape_liquid_tag' do
    let(:asset) { '{% asset app.js %}' }

    describe 'single' do
      it {
        assert { "&#123;% asset app.js %&#125;" == Tdiary2jekyll::Parser::WikiFormat.escape_liquid_tag(asset) }
      }
    end

    describe 'double and next line' do
      it {
        assert {
          Tdiary2jekyll::Parser::WikiFormat.escape_liquid_tag("#{asset} #{asset}\n\n#{asset}\n") == <<EOD
&#123;% asset app.js %&#125; &#123;% asset app.js %&#125;

&#123;% asset app.js %&#125;
EOD
        }
      }
    end
  end
end
