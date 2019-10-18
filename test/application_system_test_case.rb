require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  #driven_by :rack_test
  driven_by :selenium, using: :firefox, screen_size: [1200, 1200]
end
