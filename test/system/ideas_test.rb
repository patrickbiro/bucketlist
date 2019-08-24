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

  test 'test idea edit' do
     idea = Idea.new
     idea.save!
     visit('/ideas/'+idea.id.to_s+'/edit')
     fill_in 'title', with: 'See the Matterhorn'
     fill_in 'done_count', with: 159
     click_on 'Update idea'
     click_on 'See the Matterhorn'
     assert page.has_content?('See the Matterhorn')
     assert page.has_content?('159 have done that')

   end

   test 'test idea index search without any idea' do
      Idea.all.delete_all
      visit('/ideas/index')
      assert page.has_content?('No ideas found!')
    end
end
