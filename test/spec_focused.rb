$: << File.dirname(__FILE__) + '/../lib/'
require 'mocha'
require 'redgreen'
require 'test/spec'

describe "focused methods" do
  it "context methods are extended on to the test case" do
    spec = Test::Spec::TestCase.new('stub')
    spec.testcase.should.respond_to :fcontext
    spec.testcase.should.respond_to :fdescribe
  end
  
  it "spec methods are extended on to the test case" do
    spec = Test::Spec::TestCase.new('stub')
    spec.testcase.should.respond_to :fspecify
    spec.testcase.should.respond_to :fit
  end
  
end

describe "turning on focused mode" do
  teardown do
    Test::Spec::CONTEXTS.map { |k, v| v.ignore = false }
  end
  
  it "sets ignore on all previous contexts" do
    Kernel.module_eval do
      describe("first context") { it("should never run") { assert 1 == 2 } }
      fcontext("second context") { it("focuses on this spec") { assert 1 == 1} }
    end
    Test::Spec::CONTEXTS["first context"].ignore?.should == true
    Test::Spec::CONTEXTS["second context"].ignore?.should == false
  end
  
  it "sets ignore on all previous specs" do
    Kernel.module_eval do
      describe("first context") { it("should never run") { assert 1 == 2 } }
      context("second context") { 
        it("this should be undefed") { raise }
        fit("focuses on this spec") { assert 1 == 1} }
    end
    Test::Spec::CONTEXTS["first context"].ignore?.should == true
    Test::Spec::CONTEXTS["second context"].ignore?.should == false
    p Test::Spec::CONTEXTS["second context"].testcase.instance_methods.grep(/^test/)
  end
  
  it "undefs previous spec methods when focusing on a spec" do
    
  end
  
end

describe "focused context/describe blocks" do
  setup do
    @spec = Test::Spec::TestCase.new('stub')
  end

  it "turns on focused mode for top level contexts" do
    Test::Spec.expects(:set_focused_mode).with(true).once
    Kernel.fcontext("stub context") { "foo" }
  end

  it "turns on focused mode for nested contexts" do
    Test::Spec.expects(:set_focused_mode).with(true).once
    @spec.testcase.fcontext("stub context") { "foo" }
  end
  
  it "sets all previous contexts to disabled" do
    Test::Spec.expects(:ignore_previous_specs)
    @spec.testcase.fcontext("stub context") { "foo" }
  end
  
end