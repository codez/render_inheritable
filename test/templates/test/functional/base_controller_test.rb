require 'test_helper'

class BaseControllerTest < ActionController::TestCase
  
  test "base template and partials are rendered for inherited" do
    get :inherited
    assert_match /^inherited base$/i, @response.body
    assert_match /^inherited partial base$/i, @response.body
    assert_match /^overriden partial base$/i, @response.body
  end
    
  test "base template and partials are rendered for override" do
    get :overriden
    assert_match /^overriden base$/i, @response.body
    assert_match /^inherited partial base$/i, @response.body
    assert_match /^overriden partial base$/i, @response.body
  end
  
end
