module Test::Spec::Focused
  
  def self.included(base)
    base.extend ClassMethods
    base.class_eval {
      @focused_mode = false
    }
  end
  
  module ClassMethods
    def focused_mode?
      @focused_mode 
    end

    def set_focused_mode(bool, focused_context = nil)
      @focused_mode = bool
      ignore_previous_specs(focused_context) if bool
    end

    def ignore_previous_specs(exclude = nil)
      Test::Spec::CONTEXTS.each do |name, context|
        if name.to_s != exclude.to_s # ignore every spec except the focused one
          context.ignore = true
          context.testcase.instance_variable_set(:@__ignore, true)
        end
      end
    end
    
  end
end
