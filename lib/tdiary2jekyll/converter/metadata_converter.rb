class MetadataConverter
  #
  # [param]  TD2Entry metadata
  # [return] Metadata
  #
  def self.convert(entry)
    format = nil

    frontmatter = Hash[*entry.metadata.map {|k, v|
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
                           format = v
                           nil
                         end
                       }.compact.flatten]

    Metadata.new(format: format, frontmatter: frontmatter)
  end
end
