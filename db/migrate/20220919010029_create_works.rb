class CreateWorks < ActiveRecord::Migration[6.1]
  def change
    create_table :works do |t|

      t.integer :editor_id, null: false
      t.string :url, null: false
      t.text :body, null: false
      t.timestamps
    end
  end
end
