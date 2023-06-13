class History < ApplicationRecord
  belongs_to :order
  belongs_to :instruction
  before_save :update_fields

  def update_fields
    stage = Instruction.find_by(id: instruction_id)
    stage.update!(process_instructions: fields['process_instructions'],
                  comments: fields['comments'])
  end
end
