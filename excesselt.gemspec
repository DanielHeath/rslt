version = File.read(File.expand_path("../VERSION",__FILE__)).strip

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'excesselt'
  s.version     = version
  s.summary     = 'Helps you to transform XML without using XSLT.'
  s.description = 'I had a lot of XML transformation to do and the requirements kept changing, so I sat down and wrote something that was easy to modify.'

  s.required_ruby_version     = '>= 1.8.7'
  s.required_rubygems_version = ">= 1.3.6"

  s.author            = 'Daniel Heath'
  s.email             = 'daniel.r.heath@gmail.com'
  s.homepage          = 'http://www.github.com/danielheath/excesselt'

  s.bindir             = 'bin'
#  s.executables        = ['excesselt']
#  s.default_executable = 'excesselt'

  s.add_dependency('nokogiri', '1.4.3.1')
  s.add_dependency('builder', '2.1.2')
  s.add_development_dependency('rake')
  s.add_development_dependency('rspec', '>2.0.0')
  s.add_development_dependency('rcov')
end
