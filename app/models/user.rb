class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  enum :role, admin: "admin", audience: "audience"

  has_one :impersonating_user,
          class_name: "User",
          foreign_key: :id,
          primary_key: :impersonating_user_id

  has_many :movie_user_reviews

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: self

  validates :name, presence: true
  validates :role, presence: true
end
