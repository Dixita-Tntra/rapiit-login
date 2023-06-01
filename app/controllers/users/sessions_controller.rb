# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  # sign-in
  def create
    @user = User.find_for_database_authentication(email: sign_in_params[:email])

    return render json: { messages: 'Please enter a valid email', success: false, data: {} } unless @user.present?

    if @user.valid_password?(sign_in_params[:password])
      sign_in User, @user

      render json: { messages: 'Signed In Successfully', success: true,
                     data: { role: @user.admin? ? 'admin' : 'user' } }
    else
      render json: { message: 'Please enter a valid password', success: false, data: {} }
    end
  end

  # sign-out
  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    if signed_out
      render json: { messages: 'Signed Out Successfully', success: true, data: {} }
    else
      render json: { messages: 'Failed to Sign-Out', success: false, data: {} }
    end
  end

  private

  def configure_sign_in_params
    params.require(:user).permit(:email, :password)
  end

  def respond_to_on_destroy
    head :no_content
  end
end
