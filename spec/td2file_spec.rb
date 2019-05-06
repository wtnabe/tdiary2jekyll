require 'spec_helper'

describe TD2File do
  let(:td2) { TD2File.new(File.dirname(__FILE__) + '/support/2002/200212.td2') }

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
end
