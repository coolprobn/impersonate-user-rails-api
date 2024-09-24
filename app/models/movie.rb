class Movie < ApplicationRecord
  has_many :movie_user_reviews

  validates :name, presence: true
  validates :genres, presence: true
  validates :budget_in_usd, presence: true
  validates :release_date, presence: true
end
