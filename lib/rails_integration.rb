module AbstractController
  # Add a simple render_inheritable method to AbstractController
  # to define that rendering should perform a lookup.
  class Base
      # Tell the controller, its subclasses and views to use inheritable rendering.
      def self.render_inheritable
        include RenderInheritable
      end
  end
  
  # Enhance the rendering view context class with the template lookup methods
  # if a #template_lookup_path is defined for the current controller.
  module Rendering
    module ClassMethods
      
      # Define a view context class that includes the render inheritable
      # modules.
      def view_context_class_with_lookup
        @view_context_class ||= begin
          controller = self
          Class.new(view_context_class_without_lookup) do
            if controller.respond_to?(:template_lookup_path)
              include RenderInheritable::View
            end
          end
        end
      end
      alias_method_chain :view_context_class, :lookup
        
    end
  end
end
