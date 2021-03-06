require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  def setup
    @base_title = "Ruby on Rails Tutorial Sample App | "
  end

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

  test 'should get help' do
    get :help
    assert_response :success
  end

  test 'should have correct title' do
    [:home, :contact, :about, :help].each do |page|
      get page
      assert_select 'title', "#{@base_title}#{page.capitalize}"
    end
  end
end

