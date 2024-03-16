# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

admin = User.create!(email: 'john@email.com', password: 'john@1234', name:'John', role: 'admin')

audience_mara = User.create!(email: 'mara@email.com', password: 'mara@1234', name: 'Mara', role: 'audience')
audience_tiara = User.create!(email: 'tiara@email.com', password: 'tiara@1234', name: 'Tiara', role: 'audience')
audience_wickman = User.create!(email: 'wickman@email.com', password: 'wickman@1234', name: 'Wickman', role: 'audience')
audience_pascal = User.create!(email: 'pascal@email.com', password: 'pascal@1234', name: 'Pascal', role: 'audience')

movie_titanic = Movie.create!(name: 'Titanic', release_date: Date.new(1997, 12, 19), genres: ['love story', 'real life drama'], budget_in_usd: 200_000_000)
movie_dune_one = Movie.create!(name: 'Dune: Part One', release_date: Date.new(2021, 9, 22), genres: ['sci-fi'], budget_in_usd: 165_000_000)

MovieUserReview.create!([{ user: audience_mara, movie: movie_titanic, rating: 10.0, review: 'Best of all time' }, { user: audience_pascal, movie: movie_titanic, rating: 5.5, review: 'Not my genre' }])

MovieUserReview.create!([{ user: audience_mara, movie: movie_dune_one, rating: 8.5, review: 'Best of all time' }, { user: audience_tiara, movie: movie_titanic, rating: 10.0, review: "Was worth watching. Can't wait for part 2!" }, { user: audience_wickman, movie: movie_titanic, rating: 2.0, review: "Not sure why people like this type of movie, it doesn't have proper story and just ended on cliffhangar." }])
