require 'test_helper'

class IdeaTest < ActiveSupport::TestCase
  test 'the first empty Idea created is first in the list' do
    Idea.all.delete_all
    user= User.new email: 'patrick@epfl.ch', password: 'password'
    first_idea = Idea.new title:"Test", user: user
    first_idea.save!
    second_idea = Idea.new title:"Test2", user: user
    second_idea.save!
    assert_equal(first_idea, Idea.all.first)
  end

  test 'the first complete Idea created is first in the list' do
    Idea.all.delete_all
    user= User.new email: 'patrick@epfl.ch', password: 'password'
    first_idea = Idea.new  title:"Cycle the length of the United Kingdom", user:user
    first_idea.save!
    second_idea = Idea.new title:"Visit Japan", user:user
    second_idea.save!
    assert_equal(first_idea, Idea.all.first)
  end

  test 'updated_at is changed after updating title' do
    user= User.new email: 'patrick@epfl.ch', password: 'password'
    idea = Idea.new title:'Visit Marrakech', user: user
    idea.save!
    first_updated_at = idea.updated_at
    idea.title = 'Visit the market in Marrakech'
    idea.save!
    refute_equal(idea.updated_at, first_updated_at)
  end

  test 'updated_at is changed after updating done_count' do
    user= User.new email: 'patrick@epfl.ch', password: 'password'
    idea = Idea.new title:'test', user:user
    idea.done_count = 150
    idea.save!
    first_updated_at = idea.updated_at
    idea.done_count = 160
    idea.save!
    refute_equal(idea.updated_at, first_updated_at)
  end

  test 'updated_at is changed after updating photo_url' do
    user= User.new email: 'patrick@epfl.ch', password: 'password'
    idea = Idea.new title:'testurl', user: user
    idea.photo_url = 'testurl'
    idea.save!
    first_updated_at = idea.updated_at
    idea.photo_url = 'testurl2'
    idea.save!
    refute_equal(idea.updated_at, first_updated_at)
  end

  #TEST search function of Idea Model
  test 'search function, one matching result' do
    user= User.new email: 'patrick@epfl.ch', password: 'password'
    idea = Idea.new title:'Stand at the top of the Empire State Building', user: user
    idea.save!
    assert_equal(Idea.search('the top').length, 1)
  end

  test 'search function, no matching results' do
    user= User.new email: 'patrick@epfl.ch', password: 'password'
    idea = Idea.new title:'Stand at the top of the Empire State Building', user: user
    idea.save!
    assert_equal(Idea.search('snorkelling').length, 0)
  end

  test 'search function, two matching results' do
    user= User.new email: 'patrick@epfl.ch', password: 'password'
    idea = Idea.new title:'Stand at the top of the Empire State Building', user: user
    idea.save!

    idea2 = Idea.new title:'Stand on the pyramids', user: user
    idea2.save!

    assert_equal(Idea.search('Stand').length, 2)
  end

  #TEST most_recent function of Idea Model
  test 'most_recent function. No Idea records exist' do
    Idea.all.delete_all
    assert_equal(Idea.most_recent().length, 0)
  end

  test 'most_recent function. Two Idea records exist.' do
    user= User.new email: 'patrick@epfl.ch', password: 'password'
    Idea.all.delete_all
    idea1 = Idea.new title:'test', user: user
    idea1.save
    idea2 = Idea.new title:'Test2', user: user
    idea2.save
    assert_equal(Idea.most_recent().length, 2)
    assert_equal(Idea.most_recent().first, idea2)
  end

  test 'most_recent function. Six Idea records exist.' do
    user= User.new email: 'patrick@epfl.ch', password: 'password'
    Idea.all.delete_all
    6.times do |i|
      idea = Idea.new title:"Exciting Idea #{i+1}", user: user
      idea.save!
    end

    assert_equal(Idea.most_recent().length, 3)
    assert_equal(Idea.most_recent().first.title, "Exciting Idea 6")
  end

  #Test search function of Idea Model allowing to search description
  test 'search function with description, Only description match' do
    user= User.new email: 'patrick@epfl.ch', password: 'password'
    idea = Idea.new title:'Surfing in Portugal', user: user
    idea.description = 'See what Atlantic coast waves are like!'
    idea.save!

    assert_equal(Idea.search('coast').length, 1)
  end

  test 'Description and title match' do
    user= User.new email: 'patrick@epfl.ch', password: 'password'
    idea = Idea.new title:'Overnight hike in Switzerland', user: user
    idea.description = 'Stay in a Swiss refuge in the mountains.'
    idea.save!

    idea2 = Idea.new title:'Hike the mountains in Italy', user: user
    idea2.description = 'See the Dolomites and Italian Alps.'
    idea2.save!

    assert_equal(Idea.search('mountains').length, 2)
  end

  test 'Test idea title validation including Char limit of 75' do
    user= User.new email: 'patrick@epfl.ch', password: 'password'
    idea = Idea.new title:'', user: user
    idea.title = 'We can define validation rules within our Rails applications quite simply. The most common place to define validations rules in a Rails applicaiton is within our model classes'
    refute(idea.valid?)
    idea2 = Idea.new title:'', user: user
    refute(idea.valid?)


  end

end
