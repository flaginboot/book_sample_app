class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation

#  attr_protected :encrypted_password

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true,
                   length: { maximum: 50 }
  validates :email, presence: true,
                    format: { with: email_regex },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true,
                       confirmation: true,
                       length: { within: 6..40 }

  before_save :encrypt_password
#  after_save :make_password_nil

#  def make_password_nil
#    @password = nil
#    password = nil
#  end

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && BCrypt::Password.new(user.encrypted_password) == password
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.encrypted_password = BCrypt::Password.create(self.password)
    end
  end
end

