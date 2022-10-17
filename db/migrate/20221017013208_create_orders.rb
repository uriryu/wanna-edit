class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :user_id, null: false
			t.integer :payment_method, null: false, default: 0
			t.integer :total_payment, null: false
			t.integer :status, default: 0, null: false
			t.integer :deadline, null: false
			t.string :name, null: false
      t.timestamps
    end
  end
end
