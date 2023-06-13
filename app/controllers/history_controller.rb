class HistoryController < ApplicationController
  def index
    data = []

    History.all.each do |i|
      obj = {
        id: i.id,
        order: i.order.name,
        process: i.instruction.order_process.name,
        instructions: i.instruction
      }
      data << obj
    end
    data = data.sort_by { |hash| hash[:instructions][:created_at] }.reverse
    render json: { data:, message: 'Recent Activity History', success: true }
  end

  def create
    instruction_id = history_params[:instruction_id]
    process_id = Instruction.find_by(id: instruction_id).order_process_id
    order_id = OrderProcess.find_by(id: process_id).order_id
    record = History.new(order_id:, instruction_id:, fields: history_params[:fields])
    if record.save
      render json: { data: record, message: 'data saved to history', success: true }
    else
      render json: { message: 'failed to save', success: false }
    end
  end

  def history_params
    params.require(:history).permit(:instruction_id, fields: %i[process_instructions comments])
  end
end
