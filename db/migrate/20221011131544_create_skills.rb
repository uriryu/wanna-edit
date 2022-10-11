class CreateSkills < ActiveRecord::Migration[6.1]
  def change
    create_table :skills do |t|
      t.integer :user_id
      t.string :name, null: false
      t.text :body, null: false
      t.integer :price, null: false
    	t.boolean :is_active, null: false, default: true
      t.timestamps
    end
  end
end
