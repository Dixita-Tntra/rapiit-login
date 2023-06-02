class Users::InvitationsController < Devise::InvitationsController
  before_action :authenticate_user!
  before_action :authorize_user, only: [:create]

  def create
    resource = resource_class.find_or_initialize_by(email: invite_resource_params[:email])
    if resource.persisted?
      if resource.invited_to_sign_up? && resource.invitation_accepted?
        return render json: { message: 'User Already Invited',
                              success: false }
      end
    else
      resource.password = '123456'
      resource.departments << Department.find_by(name: invite_resource_params[:department])
      resource.roles << Role.find_by(name: invite_resource_params[:role])
    end
    resource.save!
    resource_invited = resource.invite!(current_user)
    if resource_invited
      render json: { message: 'Invitation Mail Sent', success: true }
    else
      render json: { message: 'Failed To Invite', success: false }
    end
  end

  def accept_invite
    user = resource_class.find_by(email: invite_resource_params[:email])
    return render json: { message: 'already accepted', success: false } if user.invitation_accepted?

    self.resource = resource_class.accept_invitation!(invite_resource_params)
    if !resource.errors.present?
      yield resource if block_given?
      render json: { user: resource, message: 'Registered Successfully', success: true }
    elsif resource.invitation_due_at.before?(DateTime.now)
      render json: { message: 'Invitation Token Expired', success: false }
    else
      render json: { message: 'Failed To Accept', success: false }
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

    render json: { message: 'You Don\'t Have Access Right To Invite Users', success: false }
  end
end
