require 'spec_helper'

describe Tdiary2jekyll::BodyConverter::UnescapePlugin do
  let(:footnote) { '<span class="plugin">\{\{fn \\\'この1年半ほどでようやく NewRelicの恩恵に与かりまくっている。\\\'}}</span>' }

  describe 'footnote' do
    it {
      assert {
        Tdiary2jekyll::BodyConverter::UnescapePlugin.convert(footnote, true) == "[^1]\n\n[^1]: この1年半ほどでようやく NewRelicの恩恵に与かりまくっている。\n"
      }
    }
  end
end