require 'rspec/core/rake_task'

if RUBY_VERSION =~ /^1\.8/
  desc "Run all specs with rcov"
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.rcov = true
    t.rcov_opts = %w{--exclude osx\/objc,gems\/,spec\/,features\/ --failure-threshold 100}
  end

else
  desc "Run all specs"
  RSpec::Core::RakeTask.new(:spec)
end
