class Order < ApplicationRecord
  has_many :histories
  # enum order_type: { 'new': 0, 'repeat': 1, 'design_change': 2 }
end
