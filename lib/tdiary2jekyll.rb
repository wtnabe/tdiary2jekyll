Dir.glob(File.dirname(__FILE__) + '/tdiary2jekyll/**/*.rb').each { |f| require f }

$IMAGE_DIR = File.absolute_path(File.join(__dir__, '../images'))
