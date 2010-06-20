class BaseController < ApplicationController
  
  render_inheritable
  
  def inherited
    respond_to do |format|
      format.html
      format.js
      format.xml
    end
  end
  

  def overriden
    respond_to do |format|
      format.html
      format.js
      format.xml
    end
  end
  
  
end
