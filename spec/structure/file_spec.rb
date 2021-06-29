require 'spec_helper'

describe Tdiary2jekyll::Structure::File do
  let(:td2) { Tdiary2jekyll::Structure::File.new(File.dirname(__FILE__) + '/../support/2002/200212.td2') }

  describe '#year' do
    subject   { td2.year }

    it {
      assert { subject == '2002' }
    }
  end

  describe '#month' do
    subject   { td2.month }

    it {
      assert { subject == '12' }
    }
  end

  describe '#entries' do
    subject { td2.entries }

    describe 'is array' do
      it {
        assert {
          subject.size == 4
        }
      }
    end

    describe 'not TDIARY2.00.00' do
      it {
        assert {
          subject.all? {|e| e.strip != 'TDIARY2.00.00' }
        }
      }
    end
  end
end
