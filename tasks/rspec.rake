require 'rspec/core/rake_task'

desc  "Run all specs with rcov"
RSpec::Core::RakeTask.new(:rcov) do |t|
  t.rcov = true
  t.rcov_opts = %w{--exclude osx\/objc,gems\/,spec\/,features\/}
end

desc  "Run all specs without rcov"
RSpec::Core::RakeTask.new(:rspec)

desc "Run the specs"
task :default => [:rcov]
