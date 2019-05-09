require 'spec_helper'

require_relative '../support/dummy_data'

describe WikiFormatParser do
  let(:entry) { DummyData.wiki_format_entry }

  describe '.split_to_sections' do
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
end
