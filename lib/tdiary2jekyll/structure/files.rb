module Tdiary2jekyll
  module Structure
    class Files
      #
      # [param] String path
      #
      def initialize(path)
        @path = path
      end

      #
      # [return] Array
      #
      def raw_files
        Dir.glob("#{@path}/**/*.td2")
      end
    end
  end
end
