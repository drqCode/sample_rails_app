require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:tet)
    @user2=users(:denis)
  end

  test 'should redirect index when not logged in' do
    get users_path
    assert_redirected_to login_url
  end

  test 'should get new' do
    get signup_path
    assert_response :success
    assert_select 'title', 'Sign up | Ruby on Rails App'
  end

  test 'should redirect edit when user is not logged in' do
    get edit_user_path(@user)
    refute flash.empty?
    assert_redirected_to login_url
  end

  test 'should redirect update when user is not logged in' do
    patch user_path(@user), params: {user: {name: @user.name,
                                            email: @user.email}}
    refute flash.empty?
    assert_redirected_to login_url
  end

end
