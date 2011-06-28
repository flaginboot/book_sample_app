require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get contact" do
    get :contact
    assert_response :success
  end

  test 'should get about' do
    get :about
    assert_response :success
  end

  test 'should have correct title' do
    [:home, :contact, :about].each do |page|
      get page
      assert_select 'title', "Ruby on Rails Tutorial Sample App | #{page.capitalize}"
    end
  end
end

