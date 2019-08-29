require "application_system_test_case"

class ShowIdeasTest < ApplicationSystemTestCase
  test 'that Idea are showed correctly' do #1 asertions
    #create an idea
    idea = Idea.new title:'Cycle across Australia', user: User.new
    idea.done_count = 1587
    idea.photo_url = ""
    idea.save!

    visit(idea_path(idea))
    assert page.has_content?('Cycle across Australia')
    assert page.has_content?('1587 have done that')
    assert page.has_content?(idea.created_at.strftime("%d %b %y"))
    click_on('Edit', match: :first)
    assert_equal current_path, (edit_idea_path(idea))
  end
end
