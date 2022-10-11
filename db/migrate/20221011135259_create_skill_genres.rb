class CreateSkillGenres < ActiveRecord::Migration[6.1]
  def change
    create_table :skill_genres do |t|
      t.references :skill, foreign_key: true
      t.references :genre, foreign_key: true
      t.timestamps
    end

    add_index :skill_genres, [:skill_id, :genre_id], unique: true
  end
end
