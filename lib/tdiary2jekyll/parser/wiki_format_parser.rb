require 'hikidoc'
require 'kramdown'
require 'cgi'

require_relative './base'

class WikiFormatParser < ParserBase
  class AsinParseError < StandardError; end

  #
  # [param]  String entry
  # [return] Array of WikiSection
  #
  def self.split_to_sections(entry_body)
    wedged = entry_body.sub(/^\!/m, "\v!")
    generate_section(
             wedged.split(/\v/m).select {|section| section.chomp.size > 0},
             WikiSection)
  end

  #
  # [param]  String section
  # [return] String
  #
  def self.convert(section_body)
    body = escape_liquid_tag(section_body)
    body = convert_amazon_plugin(body, false)
    body = Kramdown::Document.new(HikiDoc.to_html(body), input: 'html').to_kramdown
    body = unescape_plugin(body)

    body
  end

  #
  # copied from tDiary
  #
  # adjust Kramdown converted Markdown
  #
  # openinig bracket is escaped, and sometime inserted newline betweek html attributes
  #
  # [param]  String html
  # [return] String
  #
  def self.unescape_plugin(html)
    html.gsub!( %r!<span[\s]class="plugin">\\{\\{(.+?)}}</span>!m ) do
      CGI.unescapeHTML($1)
    end
    html.gsub!( %r!<div[\s]class="plugin">\n?\\{\\{(.+?)}}\n?</div>!m ) do
      CGI.unescapeHTML($1)
    end

    html
  end

  #
  # [return] Array
  #
  def self.plugin_converters
    Object.const_set('PLUGIN_PICKER', /\Aconvert_(.*?)_plugin\z/)

    self.methods(false).map(&:to_s).grep(PLUGIN_PICKER).map {|e| e.sub(PLUGIN_PICKER, '\1')}
  end

  #
  # [param]  String str
  # [param]  Boolean avaiable
  # [return] String
  #
  def self.convert_amazon_plugin(str, avaiable = true)
    str.gsub(/{{(isbn(_image(?:_(?:right|left))?)?) '([0-9a-zA-Z-]+)'(,[^}]+)?}}/m) {
      unless avaiable
        ''
      else

      raise AsinParseError if !$1 || !$3

      type = if $2
               'image'
             else
               'text'
             end

      "{% amazon #{type} #{$3} %}"
      end
    }
  end

  #
  # [param]  String str
  # [return] String
  #
  def self.escape_liquid_tag(str)
    str.gsub(/{%/m, '&#123;%').gsub(/%}/, '%&#125;')
  end
end
