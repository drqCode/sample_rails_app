require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'test', email: 'test@test.com')
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'name should be present' do
    @user.name = ' '
    refute @user.valid?
  end

  test 'email should be present' do
    @user.email = ' '
    refute @user.valid?
  end

  test 'name should not be too long' do
    @user.name = 't' * 55
    refute @user.valid?
  end

  test 'email should not be too long' do
    @user.email = 't' * 256
    refute @user.valid?
  end

  test 'email should accept valid addresses' do
    valid_addresses = %w[user@example.com user_at_foo@org.com user.name@example.ro
                           foo@bar-baz.com denis_shukar-rubynolog100la100@coman.ninja]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test 'email should NOT accept invalid addresses' do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com foo@bar..com]

    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      refute @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test 'email should be unique' do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    refute duplicate_user.valid?
  end


end
