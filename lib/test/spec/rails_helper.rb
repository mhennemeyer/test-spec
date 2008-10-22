module Test::Spec::RailsHelper
  
  def infer_controller_class(name)
    cleaned_name = name[0..name.index("\t")] rescue name
    cleaned_name.strip!
    cleaned_name.constantize
  rescue NameError => e
    nil
  end

  def figure_out_superclass_from_name(name_or_class, default_superclass)
    if name_or_class.is_a?(Class)
      if name_or_class < ActionController::Base
        return ActionController::TestCase
      elsif name_or_class < ActiveRecord::Base
        return ActiveSupport::TestCase
      elsif name_or_class < ActionMailer::Base
        return ActionMailer::TestCase
      end
    end
    
    default_superclass
  end
  
  extend self
end
