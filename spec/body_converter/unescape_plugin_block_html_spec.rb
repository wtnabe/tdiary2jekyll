require 'spec_helper'

describe Tdiary2jekyll::BodyConverter::UnescapePluginBlockHtml do
  let(:block_html) {
<<EOD
<div class="plugin">
{{'&lt;a
href="http://www.amazon.co.jp/exec/obidos/ASIN/4798157198"&gt;&lt;img
src="https://images-fe.ssl-images-amazon.com/images/I/51SVf5G3N0L._SL160_.jpg"
alt="技術者のためのテクニカルライティング入門講座" style="border: none;" align="right"
/&gt;技術者のためのテクニカルライティング入門講座&lt;/a&gt;'}}
</div>
EOD
  }

  describe 'block level html' do
    it {
      assert {
        unescaped = <<EOD
<a
href="http://www.amazon.co.jp/exec/obidos/ASIN/4798157198"><img
src="https://images-fe.ssl-images-amazon.com/images/I/51SVf5G3N0L._SL160_.jpg"
alt="技術者のためのテクニカルライティング入門講座" style="border: none;" align="right"
/>技術者のためのテクニカルライティング入門講座</a>
EOD

        Tdiary2jekyll::BodyConverter::UnescapePluginBlockHtml.convert(block_html) == unescaped
      }
    }
  end
end
