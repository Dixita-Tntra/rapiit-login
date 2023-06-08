class Instruction < ApplicationRecord
  belongs_to :order_process
  has_many :histories
  enum status: { 'not_started': 0, 'in_progress': 1, 'completed': 2, 'cancelled': 3 }
end
