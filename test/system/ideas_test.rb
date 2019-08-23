require "application_system_test_case"

class IdeasTest < ApplicationSystemTestCase
  test 'that Ideas are created correctly' do #1 asertions
    visit('/ideas/new')
    fill_in 'title', with: 'See the Matterhorn'
    click_on 'Create idea'
    visit('/account/ideas')
    assert page.has_content?('See the Matterhorn')
  end

  test 'that Ideas are loaded in the index' do #3 asertions

    first_idea = Idea.new
    first_idea.title = 'Cycle across Australia'
    first_idea.save!

    second_idea = Idea.new
    second_idea.title = 'See a giraffe in the wild'
    second_idea.save!

    visit('/ideas/index')
    assert page.has_content?('Cycle across Australia')
    assert page.has_content?('See a giraffe in the wild')
    #assert_equal 2, page.all(class: 'card__thumb').count
  end
end
