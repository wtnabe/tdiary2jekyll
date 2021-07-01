require_relative './base'

module Tdiary2jekyll
  module Parser
    class TdiaryFormat < Base
      #
      # @param entry [String]
      # @param metadata [Structure::Metadata]
      # @return [Array] [Section::Tdiary]
      #
      def self.split_to_sections(entry, metadata = nil)
        generate_section(entry.split(/\n\n/), Section::Tdiary, metadata)
      end
    end
  end
end
