class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise  :invitable, :database_authenticatable, :registerable,
          :rememberable, :recoverable, :validatable,
          :jwt_authenticatable, jwt_revocation_strategy: self

  has_and_belongs_to_many :roles

  def admin?
    roles.exists?(name: 'admin')
  end
end
