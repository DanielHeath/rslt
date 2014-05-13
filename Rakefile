require 'bundler'
begin
  Bundler.setup(:default, :development)
  include Rake::DSL
  Bundler::GemHelper.install_tasks
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rslt'

require 'rdoc/task'
RDoc::Task.new do |rdoc|
  version = RSLT::VERSION
  rdoc.main = "README.md"
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "<%= project_name %> #{version}"
  rdoc.rdoc_files.include('README.md')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

Dir.glob('tasks/*').each {|rakefile| load rakefile }
