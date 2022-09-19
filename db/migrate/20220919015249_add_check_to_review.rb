class AddCheckToReview < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :check, :boolean, default: false, null: false
  end
end
