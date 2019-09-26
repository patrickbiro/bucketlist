require "application_system_test_case"

class SimpleNavigationsTest < ApplicationSystemTestCase
  test 'search term is displayed' do #6 asertions
    visit('/')
    assert page.has_content?('Bucket List')
    assert page.has_selector?('.masthead')
    assert page.has_selector?('#search_input')
    #assert page.has_selector?('search_input')
    fill_in 'search_input', :with => 'test'
    click_on(class: 'btn btn--inline btn--primary')
    find('button.btn--primary').click
  end

  test 'style guide navigation' do #6 asertions
    visit('/')
    click_on('Styleguide', match: :first)
    assert page.has_content?('Atoms')
    assert page.has_content?('Molecules')
    assert page.has_content?('Organisms')
    #click_on('Molecules', match: :first)
    #assert page.has_content?('Card')
    click_on('Organisms', match: :first)
    assert page.has_content?('Create goal')
    click_on('My Bucket List', match: :first)
    #click_on(class: 'logo', match: :first)
    assert page.has_content?('Some ideas')
  end

end
