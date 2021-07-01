module Tdiary2jekyll
  module BodyConverter
    class UnescapePlugin
      #
      # @param body [String]
      # @param available [Boolish]
      # @return [String]
      #
      # :reek:BooleanParameter, :reek:ControlParameter
      def self.convert(body, available = true)
         notes = []

         new_body = body.gsub(/<span[\s]+class="plugin">(\\{\\{([[:alnum:]]+)[\s]+\\'(.+?)\\'}})<\/span>/m) do
           if available
             case $2
             when 'fn'
               # convert plugins で処理してしまうと [] が escape されてしまうのでこちらで
               notes << $3.gsub(/\n/, ' ')
               "[^#{notes.size}]"
             else
               CGI.unescapeHTML($1).gsub(/\\/, '').gsub(/{{/, '{% ').gsub(/}}/, ' %}')
             end
           else
             ''
           end
         end

         if notes.size > 0
           new_body << "\n\n"
           notes.each_with_index {|note, index|
             new_body << "[^#{index + 1}]: #{note}\n"
           }
        end

        new_body
      end
    end
  end
end
