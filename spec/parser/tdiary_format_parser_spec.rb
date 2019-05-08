require 'spec_helper'

require_relative '../support/dummy_data'

describe TDiaryFormatParser do
  let(:entry) { DummyData.tdiary_format_entry }

  describe '.split_to_sections' do
    describe 'size' do
      it {
        assert {
          TDiaryFormatParser.split_to_sections(TD2Entry.new(entry).body).size == 4
        }
      }
    end

    describe 'return TDiarySection instances' do
      it {
        assert {
          TDiaryFormatParser.split_to_sections(TD2Entry.new(entry).body).map {|s|
            s.class
          } == [TDiarySection, TDiarySection, TDiarySection, TDiarySection]
        }
      }
    end
  end
end
