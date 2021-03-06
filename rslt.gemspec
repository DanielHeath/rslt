# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "rslt"
  s.version = "1.1.10"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.authors = ["Daniel Heath"]
  s.date = "2012-04-05"
  s.description = "I had a lot of XML transformation to do and the requirements kept changing, so I sat down and wrote something that was easy to modify."
  s.email = ["daniel.r.heath@gmail.com"]
  s.extra_rdoc_files = [
    "README.md",
    "TODO"
  ]
  s.files = [
    ".travis.yml",
    "Gemfile",
    "Gemfile.lock",
    "README.md",
    "Rakefile",
    "lib/rslt.rb",
    "lib/rslt/element_wrapper.rb",
    "lib/rslt/rule.rb",
    "lib/rslt/stylesheet.rb",
    "rslt.gemspec",
    "tasks/rspec.rake"
  ]
  s.test_files = [
    "spec/element_wrapper_spec.rb",
    "spec/excesselt_spec.rb",
    "spec/spec_helper.rb",
    "spec/support/matchers/dom_matcher.rb",
  ]
  s.homepage = "http://www.github.com/danielheath/rslt"
  s.rdoc_options = ["--charset=UTF-8", "-mREADME.md"]
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.7")
  s.rubygems_version = "1.8.10"
  s.summary = "Helps you to transform XML without using XSLT."

  s.add_runtime_dependency(%q<nokogiri>)
  s.add_runtime_dependency(%q<builder>, [">= 0"])
  s.add_development_dependency(%q<activesupport>, [">= 0"])
  s.add_development_dependency(%q<rake>, [">= 0"])
  s.add_development_dependency(%q<i18n>, [">= 0"])
  s.add_development_dependency(%q<rspec>, ["> 2.0.0"])

end

