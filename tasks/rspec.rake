require 'rspec/core/rake_task'

begin
  require 'rcov'
  desc "Run all specs with rcov"
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.rcov = true
    t.rcov_opts = %w{--exclude osx\/objc,gems\/,spec\/,features\/ --failure-threshold 100}
  end
rescue LoadError
  desc "Run all specs (without coverage tests)"
  RSpec::Core::RakeTask.new(:spec)
end
