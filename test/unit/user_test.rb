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
    @travis.name = nil
    refute @travis.valid?
    assert_equal ["can't be blank"], @travis.errors[:name]
  end

  test 'should require a email address' do
    @travis.email = nil
    refute @travis.valid?
    assert_equal ["can't be blank", "is invalid"], @travis.errors[:email]
  end

  test 'should reject names that are too long' do
    @travis.name = 'a' * 51
    refute @travis.valid?
    assert_equal ["is too long (maximum is 50 characters)"], @travis.errors[:name]
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
    @duplicate_email = users(:duplicate_email)
#    @duplicate_email.password = 'password'
#    @duplicate_email.password_confirmation = 'password'
    @duplicate_email.email = 'trav@wet.com'
    assert @duplicate_email.invalid?
    assert_equal ["has already been taken"], @duplicate_email.errors[:email]
  end

  test 'should reject email addresses identical up to case' do
    @duplicate_email = users(:duplicate_email)
#    @duplicate_email.password = 'password'
#    @duplicate_email.password_confirmation = 'password'
    @duplicate_email.email = 'TRav@wEt.coM'
    assert @duplicate_email.invalid?
    assert_equal ["has already been taken"], @duplicate_email.errors[:email]
  end

  test 'should require a password' do
    @travis.password = nil
    refute @travis.valid?
  end

  test 'should require a matching password confirmation' do
    @travis.password = 'passwerd'
    @travis.password_confirmation = 'passwordy'
    refute @travis.valid?
  end

  test 'should reject short passwords' do
    @travis.password = 'passy'
    @travis.password_confirmation = 'passy'
    refute @travis.valid?
  end

  test 'should reject long passwords' do
    @travis.password = 'a' * 41
    @travis.password_confirmation = 'a' * 41
    refute @travis.valid?
  end

  test 'should have a encrypted password' do
    refute @travis.encrypted_password.blank?
  end

  test 'attr_accessible' do
    mass_assigned = User.new name: 'bobby hill', email: 'bobby_hill@aol.com', password: 'i_am_a_fat_kid', password_confirmation: 'i_am_a_fat_kid', encrypted_password: 'i_am_hacking_you'

    assert_nil mass_assigned.encrypted_password
    mass_assigned.update_attributes name: 'marky mark', encrypted_password: 'i_am_hacking_you'
    refute_equal 'i_am_hacking_you', mass_assigned.encrypted_password
    mass_assigned.encrypted_password = '1234567'
    assert_equal '1234567', mass_assigned.encrypted_password
  end
end

