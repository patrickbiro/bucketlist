require "application_system_test_case"

class IdeaCommentsTest < ApplicationSystemTestCase
  test 'adding a Comment to an Idea' do
    idea = Idea.new
    idea.title = 'Cycle across Australia'
    idea.save!

    user = User.new
    user.save!

    visit(idea_path(idea))
    fill_in 'Add comment', with: 'Such a nice experience'
    click_on('Post', match: :first)
    assert_equal(page.current_path, idea_path(idea))
    assert page.has_content?('Such a nice experience')
  end
end
