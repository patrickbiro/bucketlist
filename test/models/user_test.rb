require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'test that user creation is test insensitive' do
    user= User.new email: 'nEw@EpFl.Ch', password: 'password'
    user.save!
    assert user.valid?
    assert_equal(user.email, 'new@epfl.ch')
  end
end
