class CreateUsersDepartments < ActiveRecord::Migration[7.0]
  def change
    create_join_table :users, :departments do |t|
      t.index %i[user_id department_id]
      t.index %i[department_id user_id]
    end
  end
end
