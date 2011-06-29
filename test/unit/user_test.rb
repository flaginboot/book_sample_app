require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @travis = users(:travis)
  end

  test 'should create a valid User' do
    assert @travis.valid?
  end

  test 'should require a name' do
    @travis.name = nil
    refute @travis.valid?
  end

  test 'should require a email address' do
    @travis.email = nil
    refute @travis.valid?
  end

  test 'should reject names that are too long' do
    @travis.name = 'a' * 51
    refute @travis.valid?
  end

  test 'should only accept valid email addresses' do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      @travis.email = address
      assert @travis.valid?
    end
  end

  test 'should reject invalid email addresses' do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      @travis.email = address
      refute @travis.valid?
    end
  end

  test 'should reject duplicate email addresses' do
    refute users(:user_with_duplicated_email).valid?
  end

  test 'should reject email addresses identical up to case' do
    refute users(:user_with_duplicated_email_diff_case).valid?
  end
end

