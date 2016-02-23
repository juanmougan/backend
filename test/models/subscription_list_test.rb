require 'test_helper'

class SubscriptionListTest < ActiveSupport::TestCase
  test "retrieve_subject_subscription_lists" do
    assert_equal 1, SubscriptionList.retrieve_subject_subscription_lists.size
    assert_equal "Quimica General", SubscriptionList.retrieve_subject_subscription_lists.first.name
  end
end
