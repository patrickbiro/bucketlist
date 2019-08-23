require "application_system_test_case"

class ShowIdeasTest < ApplicationSystemTestCase
  test 'that Idea are showed correctly' do #1 asertions
    #create an idea
    idea = Idea.new
    idea.title = 'Cycle across Australia'
    idea.done_count = 1587
    idea.photo_url = ""
    idea.save!

    #create an id
    visit('/ideas/'+idea.id.to_s)
    assert page.has_content?('Cycle across Australia')
    assert page.has_content?('1587 have done that')
    assert page.has_content?(idea.created_at.strftime("%d %b %y"))
    click_on('Edit', match: :first)
    assert_equal current_path, ('/ideas/'+idea.id.to_s+'/edit')
  end
end