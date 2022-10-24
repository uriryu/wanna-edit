class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :skill

  validates :skill_id, uniqueness: { scope: :order_id }
  validates :price, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :amount, presence: true, :numericality => { :greater_than_or_equal_to => 1 }

  enum making_status: { cannot_start: 0, waiting_start: 1, in_production: 2, completed: 3, cancel: 4 }

  def subtotal
    price * amount
  end
end
