require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user=users(:tet)
  end

  test 'invalid edit' do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: {user: {name: '',
                                            email: 'invalid',
                                            password: 'foo',
                                            password_confirmation: 'bar'}}
    assert_template 'users/edit'
  end

  test 'successful edit' do
    get edit_user_path(@user)
    assert_template 'users/edit'

    name = 'tet2'
    email = 'tet2@tet.ro'
    patch user_path(@user), params: {user: {name: name,
                                            email: email,
                                            password: '',
                                            password_confirmation: ''}}
    refute flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end
end
