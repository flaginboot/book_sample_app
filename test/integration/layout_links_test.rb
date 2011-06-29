require 'test_helper'

class LayoutLinksTest < ActionDispatch::IntegrationTest
  fixtures :all

  test '"/" should be a Home page' do
    get '/'
    assert_select 'title', /Home/
  end

  test '"/contact" should be a Contact page' do
    get '/contact'
    assert_select 'title', /Contact/
  end

  test '"/about" should be a About page' do
    get '/about'
    assert_select 'title', /About/
  end

  test '"/help" should be a Help page' do
    get '/help'
    assert_select 'title', /Help/
  end

  test 'should have a signup page at "/signup"' do
    get '/signup'
    assert_select 'title', /Sign up/
  end
end

