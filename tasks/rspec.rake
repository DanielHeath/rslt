require 'rspec/core/rake_task'

desc  "Run all specs with rcov"
RSpec::Core::RakeTask.new(:rcov) do |t|
  t.rcov = true
  t.rcov_opts = %w{--rails --exclude osx\/objc,gems\/,spec\/,features\/}
end

desc "Run the specs"
task :default => [:rcov]
