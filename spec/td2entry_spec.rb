require 'spec_helper'

describe TD2Entry do
  let(:raw) { File.read(File.dirname(__FILE__) + '/support/entry_raw_20021229.txt') }

  describe '#raw' do
    it {
      assert {
        TD2Entry.new(raw).raw.class == String
      }
    }
  end
end
