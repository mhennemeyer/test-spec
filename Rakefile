require 'rubygems'
begin
  gem 'echoe'
  require 'echoe'
rescue LoadError => e
  puts "You must install echoe to dev/test this gem"
end

require './lib/test/spec/version'

echoe = Echoe.new('test-spec', Test::Spec::VERSION) do |p|
  p.rubyforge_name = 'test-spec'
  p.author = 'Christian Neukirchen'
  p.email = 'chneukirchen@gmail.com'
  p.summary = 'Relevance fork of Behaviour Driven Development interface for Test::Unit'
  p.description = <<-EOF
  test/spec layers an RSpec-inspired interface on top of Test::Unit, so
  you can mix TDD and BDD (Behavior-Driven Development).

  test/spec is a clean-room implementation that maps most kinds of
  Test::Unit assertions to a 'should'-like syntax.
  
  This is a fork of the main version to add some features and make things a bit easier for developers.  It grew out of 
  day to day use at Relevance (http://thinkrelevance.com).
EOF
  p.url        = "http://github.com/relevance/test-spec"
  p.rdoc_pattern = /^(lib|bin|ext)|txt|rdoc|CHANGELOG|LICENSE|SPECS$/
  rdoc_template = `allison --path`.strip << ".rb"
  p.rdoc_template = rdoc_template
end

echoe.spec.executables << "specrb"
echoe.spec.add_development_dependency "allison"
echoe.spec.add_development_dependency "markaby"


desc "Make binaries executable"
task :chmod do
  Dir["bin/*"].each { |binary| File.chmod(0775, binary) }
end

desc "Generate RDox"
task "SPECS" do
  ruby "bin/specrb -Ilib:test -a --rdox >SPECS"
end

task :gem => ["SPECS"]

desc "Run all the tests"
task :test => :chmod do
  ruby "bin/specrb -Ilib:test -w #{ENV['TEST'] || '-a'} #{ENV['TESTOPTS']}"
end

begin
  require 'rcov/rcovtask'
  
  Rcov::RcovTask.new do |t|
    t.test_files = FileList['test/{spec,test}_*.rb'] + ['--', '-rs']   # evil
    t.verbose = true     # uncomment to see the executed command
    t.rcov_opts = ["--text-report",
                   "--include-file", "^lib,^test",
                   "--exclude-only", "^/usr,^/home/.*/src"]
  end
rescue LoadError
end
