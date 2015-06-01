class User < ActiveRecord::Base
  before_save {emal.downcase!}
  validates :name,presence: true,length: {maximum: 50}
  validates :email,presence:true,length:{maximum: 250}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: {with: VALID_EMAIL_REGEX},uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, length:{minimum: 6}
end