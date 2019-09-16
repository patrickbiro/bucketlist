require 'test_helper'

class RolesHelperTest < ActionView::TestCase

  attr_accessor :current_user

  test 'registered users can edit owned ideas' do
    user = User.create(email: 'test@epfl.ch')
    self.current_user = user

    idea = Idea.create(title: 'A test idea!', user: user)

    assert can_edit?(idea)
  end


end
