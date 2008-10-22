require 'yaml'
require 'rubygems/specification'
require 'test/spec'

describe 'gemspec' do
  
  it 'is safe for Github' do
    data = File.read(File.join(File.dirname(__FILE__), *%w[.. test-spec.gemspec]))
    spec = nil

    if data !~ %r{!ruby/object:Gem::Specification}
      Thread.new { spec = eval("$SAFE = 3\n#{data}") }.join
    else
      spec = YAML.load(data)
    end
    spec.should.not.be.nil
  end

end