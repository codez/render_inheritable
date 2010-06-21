module AbstractController
  # Add a simple render_inheritable method to AbstractController
  # to define that rendering should perform a lookup.
  class Base
      # Tell the controller, its subclasses and views to use inheritable rendering.
      def self.render_inheritable
        include RenderInheritable
      end
  end
  
end
