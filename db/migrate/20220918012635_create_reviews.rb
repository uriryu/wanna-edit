class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|

      t.integer :user_id, null: false
      t.integer :work_id, null: false
      t.text :body, null: false
      t.float :reputation
      t.timestamps
    end
  end
end
