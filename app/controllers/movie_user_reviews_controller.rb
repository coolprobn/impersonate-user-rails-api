class MovieUserReviewsController < ApplicationController
  def create
    movie_user_review =
      movie.movie_user_reviews.new(
        **movie_user_review_params,
        user_id: current_user.id
      )

    if movie_user_review.save
      render(json: movie_user_review)
    else
      render(
        json: movie_user_review.errors.full_messages,
        status: :unprocessable_entity
      )
    end
  end

  def update
    movie_user_review = MovieUserReview.find(params[:id])

    authorize(movie_user_review)

    if movie_user_review.update(movie_user_review_params)
      render(json: movie_user_review, include: :movie)
    else
      render(
        json: movie_user_review.errors.full_messages,
        status: :unprocessable_entity
      )
    end
  end

  private

  def movie
    return @movie if @movie

    @movie = Movie.find(params[:movie_id])
  end

  def movie_user_review_params
    params.require(:movie_user_review).permit(:rating, :review)
  end
end
