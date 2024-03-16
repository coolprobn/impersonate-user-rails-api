class CreateMovieUserReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :movie_user_reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true
      t.float :rating
      t.string :review

      t.timestamps
    end

    add_index :movie_user_reviews, [:user_id, :movie_id], unique: true
  end
end
