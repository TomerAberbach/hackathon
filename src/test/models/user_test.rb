require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # tests to make sure super_admin? returns true for the first entry
  test "super_admin? true" do
     assert users(:one).super_admin?
  end

  # tests to make sure super_admin? returns false for the second entry
  test "super_admin? false" do
     assert_not users(:two).super_admin?
  end
end
