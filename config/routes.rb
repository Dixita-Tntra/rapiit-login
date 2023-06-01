Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    invitations: 'users/invitations'
  }
  devise_scope :user do
    post 'users/invitation/accept_invite' => 'users/invitations#accept_invite'
  end
end
