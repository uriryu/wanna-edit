class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details
  has_many :skills, through: :order_details

  validates :name, presence: true
  validates :total_payment, presence: true, :numericality => { :greater_than_or_equal_to => 0 }

  scope :ordered_today, -> { where(created_at: Time.current.at_beginning_of_day..Time.current.at_end_of_day) }

  enum payment_method: {credit_card: 0, transfer: 1 }
  enum status: { waiting_deposit: 0, confirm_deposit: 1, in_production: 2, preparing: 3, completed: 4, cancel: 5 }

  def create_order_details(user)
    unless order_details.first
      cart_items = user.cart_items.includes(:skill)
      cart_items.each do |cart_item|
        skill = cart_item.skill
        OrderDetail.create!(
          order_id: id,
          skill_id: skill.id,
          price: skill.with_tax_price,
          amount: cart_item.amount
        )
      end
      cart_items.destroy_all
    end
  end

  def are_all_details_completed?
    (order_details.completed.count == order_details.count) ? true : false
  end
end
