require 'action_view'

class User < ApplicationRecord
  include ActionView::Helpers::DateHelper

  validates :user_name, uniqueness: true, presence: true
  validates :password_digest, uniqueness: true, presence: true
  validates :session_token, uniqueness: true, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  after_initialize :ensure_session_token

  attr_reader :password


  def self.generate_session_token
    SecureRandom::urlsafe_base64
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  def self.find_by_credentials(user_name, password)
    user = User.find_by(user_name: user_name)
    if user && user.is_password?(password)
      return user
    else
      return nil
    end
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end


  def password=(password)
    
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
end
