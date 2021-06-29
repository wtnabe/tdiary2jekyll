# -*- mode: ruby -*-

require 'rake/testtask'

Rake::TestTask.new(:spec) do |t|
  t.libs   << 'spec'
  t.pattern = 'spec/**/*_spec.rb'
end

desc 'convert'
task :convert do
  require_relative './lib/tdiary2jekyll'
  Tdiary2jekyll::App.run(File.dirname(__FILE__) + '/src', File.dirname(__FILE__) + '/dest')
end

desc 'yard'
task :yard do
  sh 'yard doc lib'
end
task :doc => :yard

task :default => :spec
