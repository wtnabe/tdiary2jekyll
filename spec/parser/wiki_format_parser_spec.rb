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

  describe '.convert_amazon_plugin' do
    let(:image_right) { "{{isbn_image_right 'B000FAIRPA'}}" }
    let(:image_and_alt) { "{{isbn_image_right '4756107850', 'たのしいUNIX—UNIXへの招待(坂本 文)'}}" }
    let(:text) { "{{isbn '4873113229'}}" }

    describe 'text' do
      it {
        assert {
          "{% amazon text 4873113229 %}" == WikiFormatParser.convert_amazon_plugin(text)
        }
      }
    end
  end
end
