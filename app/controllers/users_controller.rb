class UsersController < ApplicationController
  def change_password
    if current_user.update_with_password(change_password_params)
      render json: { user: current_user, message: I18n.t('success.update', resource: 'Password'), success: false }
    else
      render json: { data: [], message: I18n.t('authorization.unauthorize'), success: false }
    end
  end

  def user_departments
    data = Department.all
    render json: { data:, message: 'departments lisitng', success: true }
  end

  def user_roles
    data = Role.all
    render json: { data:, message: 'roles lisitng', success: true }
  end

  private

  def change_password_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end
end
