require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @user = users(:travis)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test '"/new" should have the right title' do
    get :new
    assert_select 'title', /Sign up/
  end

  test 'GET show' do
    get :show, id: @user
    assert_response :success
  end

  test 'GET show should have the right user' do
    get :show, id: @user
    assert_equal 'trav@wet.com', @user.email
  end
end

