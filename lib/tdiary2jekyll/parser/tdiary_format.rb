require_relative './base'

module Tdiary2jekyll
  module Parser
    class TdiaryFormat < Base
      #
      # @param entry [String]
      # @return [Array] [Section::Tdiary]
      #
      def self.split_to_sections(entry)
        generate_section(entry.split(/\n\n/), Section::Tdiary)
      end
    end
  end
end
