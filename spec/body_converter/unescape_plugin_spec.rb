require 'spec_helper'

describe Tdiary2jekyll::BodyConverter::UnescapePlugin do
  describe 'inline footnote' do
    it {
      footnote = '<span class="plugin">\{\{fn \\\'この1年半ほどでようやく NewRelicの恩恵に与かりまくっている。\\\'}}</span>'

      assert {
        Tdiary2jekyll::BodyConverter::UnescapePlugin.convert(footnote, true) == "[^1]\n\n[^1]: この1年半ほどでようやく NewRelicの恩恵に与かりまくっている。\n"
      }
    }
  end

  describe 'block level footnote' do
    it {
      footnote = <<EOD
<div class="plugin">
\\{\\{fn \\'一瞬ではあるけれど、もう一メーカーに囲い込まれて専用の DVD ライターとか用意した方が楽なんじゃねーかと思った。でもそれだけはやっちゃいかんと踏みとどまれた。\\'}}
</div>
EOD

      assert {
        Tdiary2jekyll::BodyConverter::UnescapePlugin.convert(footnote, true) == "[^1]\n\n\n[^1]: 一瞬ではあるけれど、もう一メーカーに囲い込まれて専用の DVD ライターとか用意した方が楽なんじゃねーかと思った。でもそれだけはやっちゃいかんと踏みとどまれた。\n"
      }
    }
  end
end
