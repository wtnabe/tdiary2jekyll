module Tdiary2jekyll
  module BodyConverter
    class UnescapePlugin
      #
      # @param body [String]
      # @param available [Boolish]
      # @return [String]
      #
      # :reek:BooleanParameter, :reek:ControlParameter, :reek:DuplicateMethodCall
      def self.convert(body, available = true)
         notes = []

         unescape_deep = lambda {
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
         }

         new_body = body.gsub(/<(?:span|div)[\s]+class="plugin">[\s]?(\\{\\{([[:alnum:]]+)[\s]+\\'(.+?)\\'}})[\s]?<\/(?:span|div)>/m) do
           unescape_deep.call
         end
         # class="plugin" に囲まれていない場合がある
         new_body = new_body.gsub(/({{([[:alnum:]]+)[\s]+'(.+?)'}})/m) do
           unescape_deep.call
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
