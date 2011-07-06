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

  test 'form failure should not create user' do
    assert_no_difference 'User.count' do
      post :create, user: {  }
    end
  end

#  test 'form failure should render #new page' do
#    post :create, user: { name: nil }
#    assert_redirected_to action: 'new'
#  end

  test 'create success should creat a user' do
    assert_difference 'User.count', 1 do
      post :create, user: { name: 'tttttt', email: 's@s.com', password: '1234567', password_confirmation: '1234567' }
    end
  end
end

