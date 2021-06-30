module Tdiary2jekyll
  class Util
    class << self
      #
      # @param date [Date]
      # @param section_number [Number]
      # @param section_ext [String|nil]
      # @return [String]
      #
      # :reek:ControlParameter
      def path(date:, section_number:, section_ext: nil)
        path = sprintf("%04d/%02d%02d/%02d", date.year, date.month, date.day, section_number)

        if section_ext
          "#{path}.#{section_ext}"
        else
          path
        end          
      end
    end
  end
end
