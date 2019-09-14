require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  test 'changing the associated Idea for a Comment' do
    Idea.all.delete_all
    user= User.new email: 'patrick@epfl.ch', password: 'password'
    first_idea = Idea.new title:'Test', user: user
    first_idea.save!

    comment = Comment.new
    comment.body = "I'd like to do this!"


    second_idea = Idea.new title:'Test2', user: user
    second_idea.save!

    comment.idea = second_idea
    comment.user = user
    comment.save!
    assert_equal(comment.idea.title, "Test2")
  end

  test 'cascading save' do
    Idea.all.delete_all
    user= User.new email: 'patrick@epfl.ch', password: 'password'
    first_idea = Idea.new title:"Test", user: user
    first_idea.save!

    comment = Comment.new
    comment.body = "Great idea!"

    first_idea.comments << comment
    user.comments << comment
    first_idea.save!

    assert_equal(first_idea.comments.first.body, "Great idea!")
  end

  test 'Comments are ordered correctly' do
    user= User.new email: 'patrick@epfl.ch', password: 'password'
    idea = Idea.new title:"Test", user: user
    idea.save!

    comment1 = Comment.new body: "This would be great fun"
    comment2 = Comment.new body: "I agree! I'd like to do this as well"

    idea.comments << comment1
    idea.comments << comment2
    user.comments << comment1
    user.comments << comment2

    idea.save!

    assert_equal(idea.comments.first, comment1)
    assert_equal(idea.comments.length, 2)

  end
end
