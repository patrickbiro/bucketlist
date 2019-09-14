require "application_system_test_case"

class LogInsTest < ApplicationSystemTestCase
  test 'sign up creates a User' do #1 asertions
    User.all.delete_all
    visit(new_user_path)
    fill_in 'Email address', with: 'patrick@epfl.ch'
    fill_in 'Password', with: 'password'
    click_on 'Sign in'
    assert(User.all.length>0)
    assert_equal(User.first.email, 'patrick@epfl.ch')
  end

  test 'log in does not create a User' do #1 asertions
    User.all.delete_all
    user= User.new email: 'patrick@epfl.ch', password: 'password'
    visit(new_session_path)
    fill_in 'Email address', with: 'patrick@epfl.ch'
    fill_in 'Password', with: 'password'
    click_on 'Log in'
    assert(User.all.length==1)
  end


end
