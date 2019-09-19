require "application_system_test_case"

class IdeasTest < ApplicationSystemTestCase
  test 'that Ideas are created correctly' do #1 asertions
    visit(new_user_path)
    fill_in 'Email address', with: 'patrick@epfl.ch'
    fill_in 'Password', with: 'password'
    find(:button, 'Sign in').click

    visit(new_idea_path)
    fill_in 'Title', with: 'See the Matterhorn'
    click_on 'Create Idea'
    visit('/account/ideas')
    assert page.has_content?('See the Matterhorn')
  end

  test 'that Ideas are loaded in the index' do #3 asertions
    user= User.new email: 'patrick@epfl.ch', password: 'password'
    first_idea = Idea.new title:'Cycle across Australia', user: user
    first_idea.save!

    second_idea = Idea.new title:'See a giraffe in the wild', user: user
    second_idea.save!

    visit(ideas_path)
    assert page.has_content?('Cycle across Australia')
    assert page.has_content?('See a giraffe in the wild')
    #assert_equal 2, page.all(class: 'card__thumb').count
  end

  test 'test idea edit' do
    visit(new_user_path)
    fill_in 'Email address', with: 'patrick@epfl.ch'
    fill_in 'Password', with: 'password'
    find(:button, 'Sign in').click
    user= User.where("email = ?", "patrick@epfl.ch").first

    idea = Idea.new title:'Title', user: user
    idea.save!
    user.goals << idea
    visit(edit_idea_path(idea))
    fill_in 'idea_title', with: 'See the Matterhorn'
    fill_in 'idea_done_count', with: 159
    assert page.has_content?('Edit idea')
    click_on 'Update Idea'
    assert page.has_content?('My goals')
    assert page.has_content?('See the Matterhorn')
    
    click_on 'See the Matterhorn'

    assert page.has_content?('See the Matterhorn')
    assert page.has_content?('159 have done that')

  end

  test 'test idea index search without any idea' do
    Idea.all.delete_all
    visit(ideas_path)
    assert page.has_content?('No ideas found!')
  end

  test 'Last 3 Ideas are loaded in the index' do #4 asertions
    Idea.all.delete_all
    user= User.new email: 'patrick@epfl.ch', password: 'password'
    idea1 = Idea.new title:'Exciting idea 1', user: user
    idea1.save!

    idea2 = Idea.new title:'Exciting idea 2', user: user
    idea2.save!

    idea3 = Idea.new title:'Exciting idea 3', user: user
    idea3.save!

    idea4 = Idea.new title:'Exciting idea 4', user: user
    idea4.save!

    visit('/')
    assert page.has_content?(idea2.title)
    assert page.has_content?(idea3.title)
    assert page.has_content?(idea4.title)
    refute page.has_content?(idea1.title)
  end

  test 'Test validation critera for idea creation. Less than 75 char' do #4 asertions

    visit(new_user_path)
    fill_in 'Email address', with: 'patrick@epfl.ch'
    fill_in 'Password', with: 'password'
    find(:button, 'Sign in').click

    visit(new_idea_path)
    fill_in 'idea_title', with: 'Add a section in the app/views/ideas/_form.html.erb partial that will display all error associated with a failed save. An HTML fragment has been provided in the resources section of this unit as a template. Make use of the #join method to separate each error with a <br /> element.'
    fill_in 'idea_done_count', with: 159
    click_on 'Create Idea'
    assert page.has_content?('Title is too long (maximum is 75 characters)')

  end

  test 'Test validation critera for edition. Less than 75 char' do #4 asertions
    visit(new_user_path)
    fill_in 'Email address', with: 'patrick@epfl.ch'
    fill_in 'Password', with: 'password'
    find(:button, 'Sign in').click
    user= User.where("email = ?", "patrick@epfl.ch").first

    Idea.all.delete_all
    idea1 = Idea.new title:'Exciting idea 1', user: user
    idea1.save!

    visit(edit_idea_path(idea1))
    fill_in 'idea_title', with: 'Add a section in the app/views/ideas/_form.html.erb partial that will display all error associated with a failed save. An HTML fragment has been provided in the resources section of this unit as a template. Make use of the #join method to separate each error with a <br /> element.'
    click_on 'Update Idea'
    assert page.has_content?('Title is too long (maximum is 75 characters)')
  end



end
