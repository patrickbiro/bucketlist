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
end
