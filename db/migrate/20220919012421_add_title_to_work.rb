class AddTitleToWork < ActiveRecord::Migration[6.1]
  def change
    add_column :works, :title, :string
  end
end
