require 'spec_helper'

require 'time'

describe Tdiary2jekyll::BodyConverter::ImageTag do
  let(:date) { Time.parse('2021-07-01') }
  let(:metadata) {
    Tdiary2jekyll::Structure::Metadata.new(
      format: 'Wiki',
      frontmatter: {
        'date' => date
      }
    )
  }

  before {
    RR.stub(Tdiary2jekyll::BodyConverter::ImageTag).path(Time.parse('2021-07-01'), '0') {
      '20210701_0.jpg'
    }
  }
  
  it '{{image 0, \'\', nil, [400,305]}}' do
    tag = "{{image 0, '', nil, [400,305]}}"

    assert {
      Tdiary2jekyll::BodyConverter::ImageTag.convert(tag, metadata) == '{{\'<img alt="" src="/assets/images/diary/20210701_0.jpg">\'}}'
    }
  end

  it '{{image 0, \'\', nil, ["100%",nil]}}' do
    tag = "{{image 0, '', nil, [\"100%\",nil]}}"

    assert {
      Tdiary2jekyll::BodyConverter::ImageTag.convert(tag, metadata) == '{{\'<img alt="" src="/assets/images/diary/20210701_0.jpg">\'}}'
    }
  end

  it '{{image 0, \'\', nil, nil}}' do
    tag = "{{image 0, '', nil, nil}}"

    assert {
      Tdiary2jekyll::BodyConverter::ImageTag.convert(tag, metadata) == '{{\'<img alt="" src="/assets/images/diary/20210701_0.jpg">\'}}'
    }
  end

  it '{{image 0, \'alt\', nil, nil}}' do
    tag = "{{image 0, 'alt', nil, nil}}"

    assert {
      Tdiary2jekyll::BodyConverter::ImageTag.convert(tag, metadata) == '{{\'<img alt="alt" src="/assets/images/diary/20210701_0.jpg">\'}}'
    }
  end

  it '{{image \'0\', \'alt\', nil, nil}}' do
    tag = "{{image '0', 'alt', nil, nil}}"

    assert {
      Tdiary2jekyll::BodyConverter::ImageTag.convert(tag, metadata) == '{{\'<img alt="alt" src="/assets/images/diary/20210701_0.jpg">\'}}'
    }
  end

  it '{{image \'0\', \'alt\', nil}}' do
    tag = "{{image '0', 'alt', nil}}"

    assert {
      Tdiary2jekyll::BodyConverter::ImageTag.convert(tag, metadata) == '{{\'<img alt="alt" src="/assets/images/diary/20210701_0.jpg">\'}}'
    }
  end

  it '{{image( \'0\', \'alt\', nil, nil )}}' do
    tag = "{{image( '0', 'alt', nil, nil )}}"

    assert {
      Tdiary2jekyll::BodyConverter::ImageTag.convert(tag, metadata) == '{{\'<img alt="alt" src="/assets/images/diary/20210701_0.jpg">\'}}'
    }
  end
end
