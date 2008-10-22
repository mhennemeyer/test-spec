module Test::Spec::RailsHelpers
  
  def infer_controller_class(name)
    cleaned_name = name[0..name.index("\t")] rescue name
    cleaned_name.strip!
    cleaned_name.constantize
  rescue NameError => e
    nil
  end
  
  extend self
end
