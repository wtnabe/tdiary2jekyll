require 'spec_helper'

describe Tdiary2jekyll::Structure::Files do
  describe '#raw_files' do
    let(:raw_files) {
      Tdiary2jekyll::Structure::Files.new(File.dirname(__FILE__) + '/../support').raw_files
    }
    subject {
      raw_files.map {|e| File.basename(e)}.sort
    }

    it {
      assert {
        subject == ['200212.td2', '201801.td2']
      }
    }
  end
end
