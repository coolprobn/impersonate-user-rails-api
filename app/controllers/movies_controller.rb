class MoviesController < ApplicationController
  def index
    movies = Movie.all

    render(json: movies)
  end

  def create
    new_movie = Movie.new(movie_params)

    if new_movie.save
      render(json: new_movie.serializable_hash(include: { user_reviews: { method: :aggregated_rating } }))
    else
      render(new_movie.errors.full_messages, status: :unprocessable_entity)
    end
  end

  def show
    render(json: movie.serializable_hash(include: { user_reviews: { method: :aggregated_rating } }))
  end

  def update
    if movie.update(movie_params)
      render(json: movie.serializable_hash(include: { user_reviews: { method: :aggregated_rating } }))
    else
      render(movie.errors.full_messages, status: :unprocessable_entity)
    end
  end

  def destroy
    movie.destroy!

    head(:no_content)
  end

  private

  def movie_params
    params.require(:movie).permit(:id, :name, :genres, :budget_in_usd, :release_date)
  end

  def movie
    return @movie if @movie

    Movie.find(params[:id])
  end
end
