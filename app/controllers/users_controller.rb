class UsersController < ApplicationController
  def user_departments
    data = Department.all
    render json: { data:, message: 'departments lisitng', success: true }
  end

  def user_roles
    data = Role.all
    render json: { data:, message: 'roles lisitng', success: true }
  end
end
