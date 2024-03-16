class MovieUserReviewsController < ApplicationController
  def create
    movie_user_review = MovieUserReview.new(movie_user_review_params)

    if movie_user_review.save
      render(json: movie_user_review)
    else
      render(json: movie_user_review.errors.full_messages, status: :unprocessable_entity)
    end
  end

  private

  def movie_user_review_params
    params.require(:movie_user_review).permit(:user_id, :rating, :review)
  end
end
