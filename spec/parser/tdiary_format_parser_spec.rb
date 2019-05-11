require 'spec_helper'

require_relative '../support/dummy_data'

describe TdiaryFormatParser do
  let(:entry) { DummyData.tdiary_format_entry }

  describe '.split_to_sections' do
    describe 'size' do
      it {
        assert {
          TdiaryFormatParser.split_to_sections(TD2Entry.new(entry).body).size == 4
        }
      }
    end

    describe 'return TdiarySection instances' do
      it {
        assert {
          TdiaryFormatParser.split_to_sections(TD2Entry.new(entry).body).all? {|s|
            s.title.chomp.size > 0 && s.body.chomp.size > 0
          }
        }
      }
    end
  end
end
