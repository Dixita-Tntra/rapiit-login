class ProcessController < ApplicationController
  def index
    data = []
    OrderProcess.all.each do |i|
      obj = {
        id: i.id,
        name: i.name,
        instructions: i.instructions
      }
      data << obj
    end
    render json: { data:, message: 'Process Stages Listed', success: true }
  end
end
