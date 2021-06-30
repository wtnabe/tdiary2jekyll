module Tdiary2jekyll
  module BodyConverter
    class InternalLink
      #
      # @param body [String]
      # @return [String]
      #
      # :reek:UncommunicativeVariable
      def self.convert(body)
        converter = lambda do |year, month, day, sec = nil|
          section = if sec
                      sec.to_i
                    else
                      1
                    end

          if year.to_i > 3000
            p body
          end
          
          Tdiary2jekyll::Util.path(
            date: Date.new(*([year, month, day].map {|e| e.to_i})),
            section_number: section)
        end

        new_body = body.gsub(/(?:\?date=([0-9]{4})([0-9]{2})([0-9]{2}))(?:#p([0-9]{2}))?/) do
          converter.call($1, $2, $3, $4)
        end

        new_body = new_body.gsub(/([(|])([0-9]{4})([0-9]{2})([0-9]{2})\.html(?:#p([0-9]{2}))?/) do
          "#{$1}../../../" + converter.call($2, $3, $4, $5)
        end
      end
    end
  end
end
