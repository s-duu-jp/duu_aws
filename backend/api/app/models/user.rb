# Description: User model that represents the user table in the database.
class User < ApplicationRecord
  has_secure_password

  validates :uid, presence: true, uniqueness: true
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :status_type, presence: true, inclusion: { in: %w[active inactive pending removed] }
  validates :role_type, presence: true, inclusion: { in: %w[admin user guest] }
  validates :oauth_type, presence: true, inclusion: { in: %w[local google] }

  enum status_type: { active: 'active', inactive: 'inactive', pending: 'pending', removed: 'removed' }
  enum role_type: { admin: 'admin', user: 'user', guest: 'guest' }
  enum oauth_type: { local: 'local', google: 'google' }
end
