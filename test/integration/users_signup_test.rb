require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test 'invalid signup information' do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: {user: {name: '',
                                       email: 'fcsb@slabi',
                                       password: '123435',
                                       password_confirmation: '123433'}}
    end
    assert_template 'users/new'
    assert_select 'div[id=?]', 'error_explanation'
    assert_select 'div[class=?]', 'field_with_errors'
  end

  test 'invalid password confirmation' do
    get signup_path
    post signup_path, params: {user: {name: 'test',
                                     email: 'fcsb@slabi.com',
                                     password: '123123',
                                     password_confirmation: '123124'}}
    assert_template 'users/new'
    assert_select 'ul>li', text: "Password confirmation doesn't match Password"
  end


  test 'valid signup information' do
    get signup_path
    assert_changes 'User.find_by_email("fcsb@slabi.ro")' do
      post signup_path, params: {user: {name: 'test',
                                       email: 'fcsb@slabi.ro',
                                       password: '123435',
                                       password_confirmation: '123435'}}
    end
    assert_response :redirect
    follow_redirect!
    assert is_logged_in?
    User.find_by_email('fcsb@slabi.ro').destroy

  end


end
