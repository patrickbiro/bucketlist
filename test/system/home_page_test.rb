require "application_system_test_case"

class HomePagesTest < ApplicationSystemTestCase
  test 'that Ideas are loaded in the index' do #3 asertions
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
