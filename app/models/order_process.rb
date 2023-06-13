class OrderProcess < ApplicationRecord
  belongs_to :order
  has_many :instructions
end
