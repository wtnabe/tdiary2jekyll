require 'spec_helper'

require_relative '../support/dummy_data'

describe Tdiary2jekyll::Structure::Entry do
  let(:raw) { DummyData.wiki_format_entry }

  describe 'cannot parse' do
    it {
      assert {
        begin
          Tdiary2jekyll::Structure::Entry.new('')
          false
        rescue Tdiary2jekyll::Structure::Entry::CannotParseEntry
          true
        end
      }
    }
  end

  describe '#raw' do
    it {
      assert {
        Tdiary2jekyll::Structure::Entry.new(raw).raw.class == String
      }
    }
  end

  describe '#metadata' do
    it {
      assert {
        Tdiary2jekyll::Structure::Entry.new(raw).metadata.class == Hash
      }
    }
  end

  describe '#chop_terminator' do
    describe 'include \n.\n' do
      it {
        assert {
          Tdiary2jekyll::Structure::Entry.new(raw).chop_terminator("1234\n.\n") == '1234'
        }
      }
    end

    describe 'not include \n.\n' do
      it {
        assert {
          Tdiary2jekyll::Structure::Entry.new(raw).chop_terminator('1234') == '1234'
        }
      }
    end
  end

  describe '#date' do
    it {
      assert {
        Tdiary2jekyll::Structure::Entry.new(raw).date.class == Date
      }
    }
  end
end
