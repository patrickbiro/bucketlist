require "application_system_test_case"

class IdeaCommentsTest < ApplicationSystemTestCase

  test 'adding a Comment to an Idea' do
    user= User.new email: 'test@epfl.ch', password: 'password'
    idea = Idea.new title:'Cycle across Australia', user: user
    idea.save!


    visit(new_session_path)
    fill_in 'email', with: 'test@epfl.ch'
    fill_in 'password', with: 'password'
    find(:button, 'Log in').click

    visit(idea_path(idea, locale: :en))
    assert page.has_content?('Cycle across Australia')
    fill_in 'Add comment', with: 'Such a nice experience'
    #click_on('Post', match: :first)
    find('input.btn btn--primary').click
    visit(idea_path(idea)) #as JS is not supported by Capybara
    assert_equal(page.current_path, idea_path(idea))
    assert page.has_content?('Such a nice experience')
  end

  test 'comments cannot be added when not logged in' do #1 asertions
    user= User.new email: 'test@epfl.ch', password: 'password'
    idea = Idea.new title:'Cycle across Australia', user: user
    idea.save!
    visit(idea_path(idea, locale: :en))
    refute page.has_content?('Add Comment')
  end

end
