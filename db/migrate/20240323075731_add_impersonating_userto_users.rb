class AddImpersonatingUsertoUsers < ActiveRecord::Migration[7.1]
  def change
    change_table(:users) do |t|
      t.references :impersonating_user, foreign_key: { to_table: :users }
    end
  end
end
