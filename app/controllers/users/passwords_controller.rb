# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      render json: { user: resource, message: I18n.t('devise.passwords.send_instructions'), success: true }
    else
      render json: { user: resource, message: 'mail not sent!', success: false }
    end
  end

  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    yield resource if block_given?

    if resource.errors.empty?
      resource.update(password: params[:user][:password], jti: SecureRandom.uuid)
      render json: { user: resource, message: I18n.t('devise.passwords.updated_not_active'), success: true }
    else
      render json: { user: resource, message: 'failed to reset the password!', success: false }
    end
  end

  private

  def resource_params
    params.require(:user).permit!
  end
end
