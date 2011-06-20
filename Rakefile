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
require 'jeweler'
require 'excesselt'
Jeweler::Tasks.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'excesselt'
  s.version     = Excesselt::VERSION
  s.summary     = 'Helps you to transform XML without using XSLT.'
  s.description = 'I had a lot of XML transformation to do and the requirements kept changing, so I sat down and wrote something that was easy to modify.'

  s.required_ruby_version     = '>= 1.8.7'
  s.required_rubygems_version = ">= 1.3.6"

  s.author            = 'Daniel Heath'
  s.email             = ['daniel.r.heath@gmail.com']
  s.homepage          = 'http://www.github.com/danielheath/excesselt'

# Would be good to take a stylesheet and an xml file as arguments for a binary.
#  s.bindir             = 'bin'
#  s.executables        = ['excesselt'] 
#  s.default_executable = 'excesselt'

  s.rdoc_options    = ["--charset=UTF-8", "-mREADME.md"]

  s.add_dependency('nokogiri', '~>1')
  s.add_dependency('builder', '>2')
  s.add_development_dependency('activesupport')
  s.add_development_dependency('rake')
  s.add_development_dependency('i18n')
  s.add_development_dependency('rspec', '>2.0.0')
  s.add_development_dependency('rcov')
  s.add_development_dependency('ruby-debug')
  s.add_development_dependency('jeweler')
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = Excesselt::VERSION
  rdoc.main = "README.md"
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "<%= project_name %> #{version}"
  rdoc.rdoc_files.include('README.md')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

Dir.glob('tasks/*').each {|rakefile| load rakefile }
