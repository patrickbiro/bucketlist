require "application_system_test_case"

class IdeasTest < ApplicationSystemTestCase
  test 'that Ideas are created correctly' do #1 asertions
    visit(new_idea_path)
    fill_in 'Title', with: 'See the Matterhorn'
    click_on 'Create Idea'
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

    visit(ideas_path)
    assert page.has_content?('Cycle across Australia')
    assert page.has_content?('See a giraffe in the wild')
    #assert_equal 2, page.all(class: 'card__thumb').count
  end

  test 'test idea edit' do
     idea = Idea.new
     idea.save!
     visit(edit_idea_path(idea))
     fill_in 'idea_title', with: 'See the Matterhorn'
     fill_in 'idea_done_count', with: 159
     click_on 'Update Idea'
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

      idea1 = Idea.new
      idea1.title = "Exciting idea 1"
      idea1.save!

      idea2 = Idea.new
      idea2.title = "Exciting idea 2"
      idea2.save!

      idea3 = Idea.new
      idea3.title = "Exciting idea 3"
      idea3.save!

      idea4 = Idea.new
      idea4.title = "Exciting idea 4"
      idea4.save!

      visit('/')
      assert page.has_content?(idea2.title)
      assert page.has_content?(idea3.title)
      assert page.has_content?(idea4.title)
      refute page.has_content?(idea1.title)
    end


end
