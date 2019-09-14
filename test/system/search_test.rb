require "application_system_test_case"

class SearchTest < ApplicationSystemTestCase
  test 'test search function including title and description' do
     Idea.all.delete_all
     user= User.new email: 'patrick@epfl.ch', password: 'password'
     idea1 = Idea.new title:'Go cycling across Europe', user: user
     idea1.description ="An amazing way to see lots of Europe"
     idea1.save!

     idea2 = Idea.new title:'Visit Provence', user: user
     idea2.description ="Go to vineyards, go cycling up Mont Ventoux, see the fields of lavender"
     idea2.save!

     idea3 = Idea.new title:'Overnight hike in Switzerland', user: user
     idea3.description ="Stay in a Swiss refuge in the mountains"
     idea3.save!

     visit(root_path)
     fill_in 'search_input', with: 'cycling'
     assert page.has_content?('Go cycling across Europe')
     assert page.has_content?('Visit Provence')
     assert page.has_content?('Overnight hike in Switzerland')
   end
end
