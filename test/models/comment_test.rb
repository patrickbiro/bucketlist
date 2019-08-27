require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  test 'changing the associated Idea for a Comment' do
    Idea.all.delete_all
    first_idea = Idea.new
    first_idea.title="Test"
    first_idea.save!

    comment = Comment.new
    comment.body = "I'd like to do this!"


    second_idea = Idea.new
    second_idea.title="Test2"
    second_idea.save!

    comment.idea = second_idea
    comment.save!
    assert_equal(comment.idea.title, "Test2")
  end

  test 'cascading save' do
    Idea.all.delete_all
    first_idea = Idea.new title:"Test"
    first_idea.save!

    comment = Comment.new
    comment.body = "Great idea!"

    first_idea.comments << comment
    first_idea.save!

    assert_equal(first_idea.comments.first.body, "Great idea!")
  end

  test 'Comments are ordered correctly' do
    idea = Idea.new title:"Test"
    idea.save!

    comment1 = Comment.new body: "This would be great fun"
    comment2 = Comment.new body: "I agree! I'd like to do this as well"

    idea.comments << comment1
    idea.comments << comment2

    idea.save!

    assert_equal(idea.comments.first, comment1)
    assert_equal(idea.comments.length, 2)

  end
end
