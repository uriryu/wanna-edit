class CreateCartItems < ActiveRecord::Migration[6.1]
  def change
    create_table :cart_items do |t|

      t.integer :amount, null: false
      t.integer :skill_id, null: false
      t.integer :user_id, null: false
      t.timestamps
    end
  end
end
