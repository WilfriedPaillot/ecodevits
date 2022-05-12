require 'test_helper'

class UserTrainingsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get user_trainings_new_url
    assert_response :success
  end

  test "should get create" do
    get user_trainings_create_url
    assert_response :success
  end

end
