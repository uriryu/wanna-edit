class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|

      t.references :user, foreign_key: true
      t.references :work, foreign_key: true
      t.index [:user_id, :work_id], unique: true

      t.timestamps
    end
  end
end
