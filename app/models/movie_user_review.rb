class MovieUserReview < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :rating, presence: true
  validates :review, presence: true

  validates :user_id, uniqueness: { scope: [:movie_id] }

  scope :aggregated_rating, lambda {
    all_ratings = all.pluck(:rating)

    all_ratings.sum / all_ratings.length    
  }
end
