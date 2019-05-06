require 'spec_helper'

describe MetadataConverter do
  let(:entry) {
    entry = NKF.nkf('-w',
                File.read(
                     File.dirname(__FILE__) + '/../support/entry_raw_20021229.txt',
                     encoding: 'ascii-8bit'))

    TD2Entry.new(entry)
  }

  describe '.convert' do
    it 'get Metadata instances' do
      assert {
        MetadataConverter.convert(entry).class == Metadata
      }
    end

    it 'all keys small case' do
      assert {
        keys = MetadataConverter.convert(entry).frontmatter.keys
        keys == keys.map {|k| k.downcase}
      }
    end

    describe 'date with timezone' do
      subject { MetadataConverter.convert(entry).frontmatter['date'] }

      it 'include 2002-12-29' do
        assert {
          subject.include?('2002-12-29')
        }
      end

      it 'not just date' do
        assert {
          subject != '2002-12-29'
        }
      end
    end
  end
end
