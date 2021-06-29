require 'spec_helper'

describe Tdiary2jekyll::BodyConverter::PluginAmazon do
  let(:image_right) { "{{isbn_image_right 'B000FAIRPA'}}" }
  let(:image_and_alt) { "{{isbn_image_right '4756107850', 'たのしいUNIX—UNIXへの招待(坂本 文)'}}" }
  let(:text) { "{{isbn '4873113229'}}" }
  let(:multi) { "{{isbn '4873112672'}} {{isbn_image_right '4873112672', '詳解 シェルスクリプト(アーノルド ロビンス/ネルソン・H.F. ベーブ)'}}" }

  describe 'text' do
    it {
      assert {
        "{% amazon text 4873113229 %}" == Tdiary2jekyll::BodyConverter::PluginAmazon.convert(text, true)
      }
    }
  end

  describe 'image_right' do
    it {
      assert {
        "{% amazon image B000FAIRPA %}" == Tdiary2jekyll::BodyConverter::PluginAmazon.convert(image_right, true)
      }
    }
  end

  describe 'image_and_alt' do
    it {
      assert {
        "{% amazon image 4756107850 %}" == Tdiary2jekyll::BodyConverter::PluginAmazon.convert(image_and_alt, true)
      }
    }
  end

  describe 'multiple times' do
    it {
      "{% amazon text 4873112672 %} {% amazon image 4873112672 %}" == Tdiary2jekyll::BodyConverter::PluginAmazon.convert(multi, true)
    }
  end
end
