require 'spec_helper'

describe Tdiary2jekyll::BodyConverter::UnescapePluginInlineHtml do
  let(:inline_html) {
<<EOD
<span class="plugin">\\{\\{\\'&lt;a
 href=\\"https://www.amazon.co.jp/dp/4798144649\\"&gt;グラス片手にデータベース設 計
 販売管理システム編 第2版 (DB Magazine Selection) \\| 梅田 弘之 \\|本 \\| 通販 \\|
 Amazon&lt;/a&gt;\\'}}</span>
EOD
  }

  describe 'inline html' do
    it {
      unescaped = <<EOD
<a
 href="https://www.amazon.co.jp/dp/4798144649">グラス片手にデータベース設 計
 販売管理システム編 第2版 (DB Magazine Selection) \\| 梅田 弘之 \\|本 \\| 通販 \\|
 Amazon</a>
EOD
      assert {
        Tdiary2jekyll::BodyConverter::UnescapePluginInlineHtml.convert(inline_html) == unescaped
      }
    }
  end
end
