class Login < ApplicationRecord
  belongs_to :user
  before_validation :ensure_user
  before_save :ensure_authentication_token
  attr_accessor :expires_in
  attr_accessor :token_type

  def ensure_user
    return true if self.user.present?
    self.user = User.create!
  end

  def ensure_authentication_token
    self.access_token = Login.generate_unique_secure_token()
  end
end
