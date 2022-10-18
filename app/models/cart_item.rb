class CartItem < ApplicationRecord
  belongs_to :user
  belongs_to :skill

  validates :skill_id, uniqueness: { scope: :user_id }
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }

  def subtotal
    skill.with_tax_price * amount
  end

end
