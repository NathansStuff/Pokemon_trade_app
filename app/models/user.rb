class User < ApplicationRecord
  has_many :items, dependent: :destroy
  has_one_attached :avatar, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:stripe_connect]


        #  Local server only
  # def can_receive_payment?
  #   uid? && provider? && access_code? && publishable_key?
  # end

  def can_receive_payment?
    current_user.access_code == 'working!' ? true : false
  end

  def user_can_receive_payment
    current_user.access_code = 'working!'
  end


  def avatar_thumbnail
    avatar.variant(resize: '100x100!').processed
  end

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
