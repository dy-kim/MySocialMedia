class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable

  has_many :likes
  has_many :posts, through: :likes

  def self.find_for_oauth(auth)
    if auth.info.email.nil?
      auth_email = "#{auth.uid}@#{auth.provider}.com"
    else
      auth_email = auth.info.email
    end

    user_already_authed = User.where(:email => auth_email)

    if user_already_authed.exists?
      return user_already_authed.first
    else
      user = User.new(name: auth.info.name, email: auth_email, password: Devise.friendly_token[0, 20])
      user.save!

      return user
    end
  end
end
