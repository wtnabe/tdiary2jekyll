# -*- coding: utf-8 -*-
require 'spec_helper'

require_relative '../support/dummy_data'

describe WikiFormatParser do
  describe '.split_to_sections' do
    let(:entry) { DummyData.wiki_format_entry }

    describe 'size' do
      it {
        assert {
          WikiFormatParser.split_to_sections(TD2Entry.new(entry).body).size == 1
        }
      }
    end

    describe 'return WikiSection instances' do
      it {
        assert {
          WikiFormatParser.split_to_sections(TD2Entry.new(entry).body).all? {|s|
            s.title.chomp.size > 0 && s.body.chomp.size > 0
          }
        }
      }
    end
  end

  describe '.unescape_plugin' do
    let(:html) {
<<EOD
<div class="plugin">
\\{\\{'&lt;a
href="http://www.amazon.co.jp/exec/obidos/ASIN/4798157198"&gt;&lt;img
src="https://images-fe.ssl-images-amazon.com/images/I/51SVf5G3N0L._SL160_.jpg"
alt="技術者のためのテクニカルライティング入門講座" style="border: none;" align="right"
/&gt;&lt;/a&gt;'}}
</div>
EOD
    }
    let(:footnote) { '<span class="plugin">\{\{fn \'この1年半ほどでようやく NewRelicの恩恵に与かりまくっている。\'}}</span>' }

    describe 'html' do
      it {
        assert {
unescaped = <<EOD
'<a
href="http://www.amazon.co.jp/exec/obidos/ASIN/4798157198"><img
src="https://images-fe.ssl-images-amazon.com/images/I/51SVf5G3N0L._SL160_.jpg"
alt="技術者のためのテクニカルライティング入門講座" style="border: none;" align="right"
/></a>'
EOD

          WikiFormatParser.unescape_plugin(html) == unescaped
        }
      }
    end

    describe 'footnote' do
      it {
        assert {
          WikiFormatParser.unescape_plugin(footnote) == "fn 'この1年半ほどでようやく NewRelicの恩恵に与かりまくっている。'"
        }
      }
    end
  end

  describe '.convert_amazon_plugin' do
    let(:image_right) { "{{isbn_image_right 'B000FAIRPA'}}" }
    let(:image_and_alt) { "{{isbn_image_right '4756107850', 'たのしいUNIX—UNIXへの招待(坂本 文)'}}" }
    let(:text) { "{{isbn '4873113229'}}" }
    let(:multi) { "{{isbn '4873112672'}} {{isbn_image_right '4873112672', '詳解 シェルスクリプト(アーノルド ロビンス/ネルソン・H.F. ベーブ)'}}" }

    describe 'text' do
      it {
        assert {
          "{% amazon text 4873113229 %}" == WikiFormatParser.convert_amazon_plugin(text)
        }
      }
    end

    describe 'image_right' do
      it {
        assert {
          "{% amazon image B000FAIRPA %}" == WikiFormatParser.convert_amazon_plugin(image_right)
        }
      }
    end

    describe 'image_and_alt' do
      it {
        assert {
          "{% amazon image 4756107850 %}" == WikiFormatParser.convert_amazon_plugin(image_and_alt)
        }
      }
    end

    describe 'multiple times' do
      it {
        "{% amazon text 4873112672 %} {% amazon image 4873112672 %}" == WikiFormatParser.convert_amazon_plugin(multi)
      }
    end
  end

  describe '.escape_liquid_tag' do
    let(:asset) { '{% asset app.js %}' }

    describe 'single' do
      it {
        assert { "&#123;% asset app.js %&#125;" == WikiFormatParser.escape_liquid_tag(asset) }
      }
    end

    describe 'double and next line' do
      it {
        assert {
          WikiFormatParser.escape_liquid_tag("#{asset} #{asset}\n\n#{asset}\n") == <<EOD
&#123;% asset app.js %&#125; &#123;% asset app.js %&#125;

&#123;% asset app.js %&#125;
EOD
        }
      }
    end
  end
end
