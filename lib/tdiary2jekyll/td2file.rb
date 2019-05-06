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
end
