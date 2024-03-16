class CreateMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :movies do |t|
      t.string :name
      t.string :genres, default: [], array: true
      t.float :budget_in_usd
      t.date :release_date

      t.timestamps
    end
  end
end
