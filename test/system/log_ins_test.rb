require "application_system_test_case"

class LogInsTest < ApplicationSystemTestCase
  test 'sign up creates a User' do #1 asertions
    User.all.delete_all
    visit(new_user_path)
    fill_in 'Email address', with: 'patrick@epfl.ch'
    fill_in 'Password', with: 'password'
    find(:button, 'Sign in').click
    assert(User.all.length>0)
    assert_equal(User.first.email, 'patrick@epfl.ch')
  end

  test 'log in does not create a User' do #1 asertions
    User.all.delete_all
    user= User.new email: 'patrick@epfl.ch', password: 'password'
    user.save!
    visit(new_session_path)
    fill_in 'email', with: 'patrick@epfl.ch'
    fill_in 'password', with: 'password'
    find(:button, 'Log in').click
    assert(User.all.length==1)
  end


end
