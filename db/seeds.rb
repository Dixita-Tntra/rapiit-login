%w[admin worker sales_person production_manager customer].each do |name|
  Role.find_or_create_by(name:)
end
puts '``````````Roles Created````````````'

%w[CAD ASSEMBLY MOLD SHEET_METAL].each do |name|
  Department.find_or_create_by(name:)
end
puts '``````````Departments Created````````````'

Order.create(name: 'dummy', order_type: 1)
puts '``````````First Order Created````````````'

%w[Blank Mold Laser Hardware Brake Assembly Inspection Shipping].each do |name|
  OrderProcess.find_or_create_by(name:, order_id: 1)
end
puts '``````````Processes Created````````````'

# dummy-data
Instruction.find_or_create_by(order_process_id: OrderProcess.find_by(name: 'Blank').id, status: 2, name: 'Shearing',
                              sheet_name: 'プレス')

Instruction.find_or_create_by(order_process_id: OrderProcess.find_by(name: 'Mold').id, status: 2,
                              name: 'C Surface Cut', sheet_name: 'プレス')

Instruction.find_or_create_by(order_process_id: OrderProcess.find_by(name: 'Brake').id, status: 2, name: 'Pre-bending',
                              sheet_name: 'プレス')

Instruction.find_or_create_by(order_process_id: OrderProcess.find_by(name: 'Hardware').id, status: 2,
                              name: '1st ZAS Comp.', sheet_name: 'プレス')

                              Instruction.find_or_create_by(order_process_id: OrderProcess.find_by(name: 'Laser').id, status: 2, name: 'Laser Rough',
                              sheet_name: 'プレス')
Instruction.find_or_create_by(order_process_id: OrderProcess.find_by(name: 'Laser').id, status: 2, name: 'Rough Data',
                              sheet_name: 'プレス')
Instruction.find_or_create_by(order_process_id: OrderProcess.find_by(name: 'Laser').id, status: 2, name: 'L/CAM',
                              sheet_name: 'プレス')
Instruction.find_or_create_by(order_process_id: OrderProcess.find_by(name: 'Laser').id, status: 2,
                              name: 'Laser Fixture', sheet_name: 'プレス')

Instruction.find_or_create_by(order_process_id: OrderProcess.find_by(name: 'Assembly').id, status: 2,
                              name: '2nd ZAS Form', sheet_name: 'プレス')

Instruction.find_or_create_by(order_process_id: OrderProcess.find_by(name: 'Inspection').id, status: 0,
                              name: '3rd ZAS Form', sheet_name: 'プレス')

Instruction.find_or_create_by(order_process_id: OrderProcess.find_by(name: 'Shipping').id, status: 0,
                              name: 'Lase Trim', sheet_name: 'プレス')

puts '``````````Process Instruction Created````````````'
