require 'spec_helper'

require_relative './support/dummy_data'

describe TD2Entry do
  let(:raw) { DummyData.wiki_format_entry }

  describe 'cannot parse' do
    it {
      assert {
        begin
          TD2Entry.new('')
          false
        rescue TD2Entry::CannotParseEntry
          true
        end
      }
    }
  end

  describe '#raw' do
    it {
      assert {
        TD2Entry.new(raw).raw.class == String
      }
    }
  end

  describe '#metadata' do
    it {
      assert {
        TD2Entry.new(raw).metadata.class == Hash
      }
    }
  end

  describe '#date' do
    it {
      assert {
        TD2Entry.new(raw).date.class == Date
      }
    }
  end
end
