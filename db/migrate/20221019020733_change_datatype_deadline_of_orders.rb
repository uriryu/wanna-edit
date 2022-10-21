class ChangeDatatypeDeadlineOfOrders < ActiveRecord::Migration[6.1]
  def change
    change_column :orders, :deadline, :date
  end
end
