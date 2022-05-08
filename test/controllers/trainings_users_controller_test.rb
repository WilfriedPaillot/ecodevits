require 'test_helper'

class TrainingsUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get trainings_users_new_url
    assert_response :success
  end

  test "should get create" do
    get trainings_users_create_url
    assert_response :success
  end

end
