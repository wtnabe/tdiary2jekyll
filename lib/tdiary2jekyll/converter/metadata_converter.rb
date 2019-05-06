require 'yaml'

class MetadataConverter
  #
  # [param] TD2Entry entry
  #
  def self.convert(entry)
    self.new(entry)
  end

  #
  # [param] Hash metadata
  #
  def initialize(entry)
    @format   = nil
    @metadata = convert(entry)
  end
  attr_reader :metadata

  #
  # [param] Hash metadata
  #
  def convert(entry)
    Hash[*entry.metadata.map {|k, v|
           key = case k
                 when 'Visible'
                   'published'
                 else
                   k.downcase
                 end

           if key != 'format'
             if key == 'date'
               [key, entry.date.to_time.to_s]
             else
               [key, v]
             end
           else
             @format = v
             nil
           end
         }.compact.flatten]
  end
end
