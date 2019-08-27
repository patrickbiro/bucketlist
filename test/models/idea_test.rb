require 'test_helper'

class IdeaTest < ActiveSupport::TestCase
  test 'the first empty Idea created is first in the list' do
    Idea.all.delete_all
    first_idea = Idea.new
    first_idea.title="Test"
    first_idea.save!
    second_idea = Idea.new
    second_idea.title="Test2"
    second_idea.save!
    assert_equal(first_idea, Idea.all.first)
  end

  test 'the first complete Idea created is first in the list' do
    Idea.all.delete_all
    first_idea = Idea.new
    first_idea.title = 'Cycle the length of the United Kingdom'
    first_idea.description = 'A multiday cycling tour along the length of the United Kingdom!'
    first_idea.photo_url = 'http://mybucketlist.ch/an_image.jpg'
    first_idea.done_count = 12
    first_idea.name_of_user = 'Peter Pan'
    first_idea.save!
    second_idea = Idea.new
    second_idea.title = 'Visit Japan'
    second_idea.description = 'Japan has a lot of exciting sights to see and things to do!'
    second_idea.photo_url = 'http://mybucketlist.ch/second_image.jpg'
    second_idea.done_count = 3
    second_idea.name_of_user = 'Wendy'
    second_idea.save!
    assert_equal(first_idea, Idea.all.first)
  end

  test 'updated_at is changed after updating title' do
    idea = Idea.new
    idea.title = 'Visit Marrakech'
    idea.save!
    first_updated_at = idea.updated_at
    idea.title = 'Visit the market in Marrakech'
    idea.save!
    refute_equal(idea.updated_at, first_updated_at)
  end

  test 'updated_at is changed after updating done_count' do
    idea = Idea.new
    idea.title = "test"
    idea.done_count = 150
    idea.save!
    first_updated_at = idea.updated_at
    idea.done_count = 160
    idea.save!
    refute_equal(idea.updated_at, first_updated_at)
  end

  test 'updated_at is changed after updating photo_url' do
    idea = Idea.new
    idea.photo_url = 'testurl'
    idea.title = 'test'
    idea.save!
    first_updated_at = idea.updated_at
    idea.photo_url = 'testurl2'
    idea.save!
    refute_equal(idea.updated_at, first_updated_at)
  end

  #TEST search function of Idea Model
  test 'search function, one matching result' do
    idea = Idea.new
    idea.title = 'Stand at the top of the Empire State Building'
    idea.save!
    assert_equal(Idea.search('the top').length, 1)
  end

  test 'search function, no matching results' do
    idea = Idea.new
    idea.title = 'Stand at the top of the Empire State Building'
    idea.save!
    assert_equal(Idea.search('snorkelling').length, 0)
  end

  test 'search function, two matching results' do
    idea = Idea.new
    idea.title = 'Stand at the top of the Empire State Building'
    idea.save!

    idea2 = Idea.new
    idea2.title = 'Stand on the pyramids'
    idea2.save!

    assert_equal(Idea.search('Stand').length, 2)
  end

  #TEST most_recent function of Idea Model
  test 'most_recent function. No Idea records exist' do
    Idea.all.delete_all
    assert_equal(Idea.most_recent().length, 0)
  end

  test 'most_recent function. Two Idea records exist.' do
    Idea.all.delete_all
    idea1 = Idea.new
    idea1.title="Test"
    idea1.save
    idea2 = Idea.new
    idea2.title="Test2"
    idea2.save
    assert_equal(Idea.most_recent().length, 2)
    assert_equal(Idea.most_recent().first, idea2)
  end

  test 'most_recent function. Six Idea records exist.' do
    Idea.all.delete_all
    6.times do |i|
      idea = Idea.new
      idea.title = "Exciting Idea #{i+1}"
      idea.save!
    end

    assert_equal(Idea.most_recent().length, 3)
    assert_equal(Idea.most_recent().first.title, "Exciting Idea 6")
  end

  #Test search function of Idea Model allowing to search description
  test 'search function with description, Only description match' do
    idea = Idea.new
    idea.title = 'Surfing in Portugal'
    idea.description = 'See what Atlantic coast waves are like!'
    idea.save!

    assert_equal(Idea.search('coast').length, 1)
  end

  test 'Description and title match' do
    idea = Idea.new
    idea.title = 'Overnight hike in Switzerland'
    idea.description = 'Stay in a Swiss refuge in the mountains.'
    idea.save!

    idea2 = Idea.new
    idea2.title = 'Hike the mountains in Italy'
    idea2.description = 'See the Dolomites and Italian Alps.'
    idea2.save!

    assert_equal(Idea.search('mountains').length, 2)
  end

  test 'Test idea title validation including Char limit of 75' do
    idea = Idea.new
    idea.title = 'We can define validation rules within our Rails applications quite simply. The most common place to define validations rules in a Rails applicaiton is within our model classes'
    refute(idea.valid?)
    idea2 = Idea.new
    idea2.title = ''
    refute(idea.valid?)


  end

end
