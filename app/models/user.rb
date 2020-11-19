class User < ApplicationRecord
  has_many :items, dependent: :destroy
  has_one_attached :avatar, dependent: :destroy
  
#-------------------------------------------------------------------------------
# Add omniauth to devise to enable omniauth to use stripe to link to user account
#-------------------------------------------------------------------------------
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:stripe_connect]


#-------------------------------------------------------------------------------
# Some logic as it applies to the user model across multiple controller views
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Checks if user stripe data was saved after connecting to Stripe (set on return in omniauth controller)
#-------------------------------------------------------------------------------
  def can_receive_payment?
    uid? && provider? && access_code? && publishable_key?
  end

#-------------------------------------------------------------------------------
# Controls the size of the user avatar image
#-------------------------------------------------------------------------------
  def avatar_thumbnail
    avatar.variant(resize: '100x100!').processed
  end

#-------------------------------------------------------------------------------
# Logging in logic as it relates to both username and password
# User name and email cannot match across users because both are used for logging in
#-------------------------------------------------------------------------------
  attr_writer :login
  def login
    @login || username || email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  validate :validate_username
  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

end
