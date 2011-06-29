require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test '"/new" should have the right title' do
    get :new
    assert_select 'title', /Sign up/
  end
end

