class Users::InvitationsController < Devise::InvitationsController
  before_action :authenticate_user!
  before_action :authorize_user, only: [:create]

  def create
    resource = resource_class.find_or_initialize_by(email: invite_resource_params[:email])

    if resource.invitation_sent_at.present? && !resource.invitation_accepted_at.nil?
      return render json: { message: 'user already invited', success: false,
                            data: {} }
    end

    resource.password = '123456'
    resource.departments << Department.find_by(name: invite_resource_params[:department])
    resource.roles << Role.find_by(name: invite_resource_params[:role])
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
    elsif resource.invitation_accepted_at.present?
      render json: { message: 'already accepted', success: false, data: {} }
    elsif resource.invitation_due_at < DateTime.now
      render json: { message: 'invitation token expired', success: false, data: {} }
    else
      render json: { message: 'failed to accept', success: false, data: {} }
    end
  end

  private

  def invite_resource_params
    params.require(:user).permit(:email, :invitation_token, :password, :department, :role)
  end

  def authorize_user
    # Check if the current user has the necessary permissions
    # Redirect or raise an error if not authorized
    return if current_user.admin?

    render json: { message: 'You don\'t have access right to invite users', success: false,
                   data: {} }
  end
end
