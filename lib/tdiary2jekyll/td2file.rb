class TD2File
  DATE_RE = /\A([0-9]{4})([0-9]{2})\z/

  #
  # [param] String path
  #
  def initialize(path)
    @path  = path
    @year  = nil
    @month = nil
  end
  attr_reader :path

  #
  # [return] String
  #
  def basename
    File.basename(path, '.td2')
  end

  #
  # [return] String
  #
  def year
    if ( !@year )
      @year = $1 if DATE_RE =~ basename
    end

    @year
  end

  #
  # [return] String
  #
  def month
    if ( !@month )
      @month = $2 if DATE_RE =~ basename
    end

    @month
  end

  #
  # [return] Array
  #
  def entries
    raw_data = File.read(path)
    wedged   = raw_data.gsub(/^((?:TDIARY2\.00\.00|\.)\n)(Date:)/m, '\1' + "\v" + '\2')

    wedged.split(/\v/)[1..-1]
  end
end
