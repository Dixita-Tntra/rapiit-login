%w[admin worker sales_person production_manager customer].each do |name|
  Role.find_or_create_by(name:)
end
puts '``````````Roles Created````````````'

%w[CAD ASSEMBLY MOLD SHEET_METAL].each do |name|
  Department.find_or_create_by(name:)
end
puts '``````````Departments Created````````````'
