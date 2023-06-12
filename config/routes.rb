Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    invitations: 'users/invitations',
    passwords: 'users/passwords'
  }
  devise_scope :user do
    post 'users/invitation/accept_invite' => 'users/invitations#accept_invite'
  end

  get 'users/departments', to: 'users#user_departments'
  get 'users/roles', to: 'users#user_roles'
end
