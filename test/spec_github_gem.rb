require 'yaml'
require 'rubygems/specification'
require 'test/spec'

describe 'gem' do
  
  it 'is safe' do
    data = File.read(File.join(File.dirname(__FILE__), *%w[.. test-spec.gemspec]))
    spec = nil

    if data !~ %r{!ruby/object:Gem::Specification}
      Thread.new { spec = eval("$SAFE = 3\n#{data}") }.join
    else
      spec = YAML.load(data)
    end
  end

end