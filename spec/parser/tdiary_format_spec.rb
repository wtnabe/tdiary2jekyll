require 'spec_helper'

require_relative '../support/dummy_data'

describe Tdiary2jekyll::Parser::TdiaryFormat do
  let(:entry) { DummyData.tdiary_format_entry }

  describe '.split_to_sections' do
    describe 'size' do
      it {
        assert {
          Tdiary2jekyll::Parser::TdiaryFormat.split_to_sections(Tdiary2jekyll::Structure::Entry.new(entry).body).size == 4
        }
      }
    end

    describe 'return TdiarySection instances' do
      it {
        assert {
          Tdiary2jekyll::Parser::TdiaryFormat.split_to_sections(Tdiary2jekyll::Structure::Entry.new(entry).body).all? {|s|
            s.title.chomp.size > 0 && s.body.chomp.size > 0
          }
        }
      }
    end
  end
end
