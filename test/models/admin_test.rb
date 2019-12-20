require 'test_helper'

class AdminTest < ActiveSupport::TestCase
  # tests to make sure super_admin? returns true for the first entry
  test "super_admin? true" do
     assert admins(:one).super_admin?
  end

  # tests to make sure super_admin? returns false for the second entry
  test "super_admin? false" do
     assert_not admins(:two).super_admin?
  end
end
