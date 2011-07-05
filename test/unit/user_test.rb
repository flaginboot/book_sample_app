require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @travis = users(:travis)
    @travis.password = 'password'
    @travis.password_confirmation = 'password'
  end

  test 'should create a valid User' do
    assert @travis.valid?
  end

  test 'should require a name' do
    refute users(:no_name).valid?
    assert_equal ["can't be blank"], users(:no_name).errors[:name]
  end

  test 'should require a email address' do
    refute users(:no_email).valid?
    assert_equal ["can't be blank", "is invalid"], users(:no_email).errors[:email]
  end

  test 'should reject names that are too long' do
    refute users(:name_too_long).valid?
    assert_equal ["is too long (maximum is 50 characters)"], users(:name_too_long).errors[:name]
  end

  test 'should only accept valid email addresses' do
    addresses = %w[user@foo.com THE_USER@foo.bar.org]
    addresses.each do |address|
      @travis.email = address
      assert @travis.valid?
      assert_equal [], @travis.errors[:email]
    end
  end

  test 'should reject invalid email addresses' do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      @travis.email = address
      refute @travis.valid?
      assert_equal ["is invalid"], @travis.errors[:email]
    end
  end

  test 'should reject duplicate email addresses' do
    refute users(:duplicated_email).valid?
    assert_equal ["has already been taken"], users(:duplicated_email).errors[:email]
  end

  test 'should reject email addresses identical up to case' do
    refute users(:duplicated_email_diff_case).valid?
    assert_equal ["has already been taken"], users(:duplicated_email_diff_case).errors[:email]
  end

  test 'should require a password' do
    user = @travis
    user.password = nil
    refute user.valid?
  end

  test 'should require a matching password confirmation' do
    user = @travis
    user.password = 'passwerd'
    user.password_confirmation = 'passwordy'
    refute user.valid?
  end

  test 'should reject short passwords' do
    user = @travis
    user.password = 'pass'
    user.password_confirmation = 'pass'
    refute user.valid?
  end

  test 'should reject long passwords' do
    user = @travis
    user.password = 'a' * 41
    user.password_confirmation = 'a' * 41
    refute user.valid?
  end

  test 'should have a encrypted password' do
    refute @travis.encrypted_password.blank?
  end

  test 'attr_protected' do
    mass_assigned = User.new name: 'bobby hill', email: 'bobby_hill@aol.com', password: 'i_am_a_fat_kid', password_confirmation: 'i_am_a_fat_kid', encrypted_password: 'i_am_hacking_you'
    assert_nil mass_assigned.encrypted_password
    mass_assigned.update_attributes name: 'marky mark', encrypted_password: 'i_am_hacking_you'
    refute_equal 'i_am_hacking_you', mass_assigned.encrypted_password
    mass_assigned.encrypted_password = '1234567'
    assert_equal '1234567', mass_assigned.encrypted_password
  end
end

