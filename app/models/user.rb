class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise  :invitable, :database_authenticatable, :registerable,
          :rememberable, :recoverable, :validatable,
          :jwt_authenticatable, jwt_revocation_strategy: self

  validates_format_of :email, with: Devise.email_regexp
  has_and_belongs_to_many :roles
  has_and_belongs_to_many :departments

  def admin?
    roles.exists?(name: 'admin')
  end
end
