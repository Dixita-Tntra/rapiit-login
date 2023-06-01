class Users::InvitationsController < Devise::InvitationsController
  before_action :authenticate_user!
  before_action :authorize_user, only: [:create]

  def create
    resource = resource_class.new(email: invite_resource_params[:email])
    resource.password = '123456'
    resource.save!
    resource_invited = resource.invite!(current_user)
    if resource_invited
      render json: { message: 'invitation mail sent', success: true, data: {} }
    else
      render json: { message: 'failed to invite', success: false, data: {} }
    end
  end

  def accept_invite
    self.resource = resource_class.accept_invitation!(invite_resource_params)
    if !resource.errors.present?
      yield resource if block_given?
      render json: { user: resource, message: 'registered successfully', success: true, data: {} }
    else
      render json: { message: 'failed to accept', success: false, data: {} }
    end
  end

  private

  def invite_resource_params
    params.require(:user).permit(:email, :invitation_token, :password)
  end

  def authorize_user
    # Check if the current user has the necessary permissions
    # Redirect or raise an error if not authorized
    return render json: { message: 'You don\'t have access right to invite users', success: false, data: {} } unless current_user.admin?
  end
end
