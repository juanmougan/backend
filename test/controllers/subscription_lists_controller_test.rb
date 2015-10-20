require 'test_helper'

class SubscriptionListsControllerTest < ActionController::TestCase
  setup do
    @subscription_list = subscription_lists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:subscription_lists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create subscription_list" do
    assert_difference('SubscriptionList.count') do
      post :create, subscription_list: {  }
    end

    assert_redirected_to subscription_list_path(assigns(:subscription_list))
  end

  test "should show subscription_list" do
    get :show, id: @subscription_list
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @subscription_list
    assert_response :success
  end

  test "should update subscription_list" do
    patch :update, id: @subscription_list, subscription_list: {  }
    assert_redirected_to subscription_list_path(assigns(:subscription_list))
  end

  test "should destroy subscription_list" do
    assert_difference('SubscriptionList.count', -1) do
      delete :destroy, id: @subscription_list
    end

    assert_redirected_to subscription_lists_path
  end
end
