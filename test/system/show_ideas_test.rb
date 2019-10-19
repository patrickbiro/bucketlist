require "application_system_test_case"

class ShowIdeasTest < ApplicationSystemTestCase
  test 'that Idea are showed correctly' do #1 asertions
    User.all.delete_all
    visit(new_user_path)
    fill_in 'Email address', with: 'patrick@epfl.ch'
    fill_in 'Password', with: 'password'
    find(:button, 'Sign in').click

    user= User.where("email = ?", "patrick@epfl.ch").first
    idea = Idea.new title:'Cycle across Australia', user: user
    idea.done_count = 1587
    idea.photo_url = ""
    idea.save!

    visit(idea_path(idea, locale: :en))
    assert page.has_content?('Cycle across Australia')
    assert page.has_content?('1587 have done that')
    #assert page.has_content?(time_ago_in_words(idea.created_at))
    click_on('Edit', match: :first)
    assert_equal "/en#{current_path}", (edit_idea_path(idea, locale: :en))
  end
end
