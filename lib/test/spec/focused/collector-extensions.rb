module Test
  module Unit
    module Collector
      class ObjectSpace
        
        # Open up the ObjectSpace Collector to check to see if we have set an ignore flag.
        def collect(name=NAME)
          suite = TestSuite.new(name)
          sub_suites = []
          @source.each_object(Class) do |klass|
            if (Test::Unit::TestCase > klass) && !klass.instance_variable_get(:@__ignore)
              add_suite(sub_suites, klass.suite)
            end
          end
          sub_suites.each {|s| suite << s }
          suite
        end
          
      end
    end
  end
end
