require "test_helper"

class MovieUserReviewsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get movie_user_reviews_create_url
    assert_response :success
  end
end
