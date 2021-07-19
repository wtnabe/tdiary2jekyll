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

          sprintf("/diary/%04d/%02d%02d/%02d/", year.to_i, month.to_i, day.to_i, section)
        end

        new_body = body.gsub(/([(|])(?:(?:\.\/index\.cgi|\/d\/)?\?date=([0-9]{4})([0-9]{2})([0-9]{2}))(?:#p([0-9]{2}))?/) do
          $1 + converter.call($2, $3, $4, $5)
        end

        new_body = new_body.gsub(/([(|])([0-9]{4})([0-9]{2})([0-9]{2})\.html(?:#p([0-9]{2}))?/) do
          $1 + converter.call($2, $3, $4, $5)
        end
      end
    end
  end
end
