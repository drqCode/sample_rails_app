require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:tet)
  end

  test 'invalid login credentials' do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: {session: {email: '', password: ''}}
    assert_template 'sessions/new'
    refute flash.empty?
    get root_path
    assert flash.empty?
  end

  test 'valid login credentials' do
    get login_path
    post login_path params: {session: {email: @user.email, password: 'password'}}
    assert_redirected_to @user
    follow_redirect!
    assert_select 'a[href=?]', login_path, count: 0
    assert_select 'a[href=?]', logout_path
    assert_select 'a[href=?]', user_path(@user)
  end

  test 'valid login credentials followed by logout' do
    get login_path
    post login_path params: {session: {email: @user.email, password: 'password'}}
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_select 'a[href=?]', login_path, count: 0
    assert_select 'a[href=?]', logout_path
    assert_select 'a[href=?]', user_path(@user)

    delete logout_path
    refute is_logged_in?
    assert_redirected_to root_url

    delete logout_path

    follow_redirect!
    assert_select 'a[href=?]', login_path
    assert_select 'a[href=?]', logout_path, count: 0
    assert_select 'a[href=?]', user_path(@user), count: 0
  end

end
