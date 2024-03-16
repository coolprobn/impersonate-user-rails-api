class Movie < ApplicationRecord
  validates :name, presence: true
  validates :genres, presence: true
  validates :budget_in_usd, presence: true
  validates :release_date, presence: true
end
