require 'test_helper'

class AccountControllerTest < ActionDispatch::IntegrationTest
  test "should get ideas" do
    get account_ideas_url
    assert_response :success
  end

end
