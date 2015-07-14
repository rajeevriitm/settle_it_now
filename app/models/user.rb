class User < ActiveRecord::Base
  attr_accessor :remember_token,:activation_token,:reset_token
  has_many :microposts,dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",foreign_key: "follower_id",dependent: :destroy
  has_many :following, through: :active_relationships,source: :followed
  has_many :passive_relationships,class_name: "Relationship",foreign_key: "followed_id",dependent: :destroy
  has_many :followers, through: :passive_relationships
  before_create :create_activation_digest
  before_save {email.downcase!}
  validates :name,presence: true,length: {maximum: 50}
  validates :email,presence:true,length:{maximum: 250}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: {with: VALID_EMAIL_REGEX},uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, length:{minimum: 6},allow_blank: true
  #creates a password digest for user model
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

# returns a random token
  def User.new_token
    SecureRandom.urlsafe_base64
  end

#remembers a user remember digest in database
  def remember
    self.remember_token=User.new_token
    self.update_attribute(:remember_digest,User.digest(remember_token))
  end

  #authenticate the remember digest with token
  def authenticated?(attribute,token)
    digest=self.send("#{attribute}_digest")
    BCrypt::Password.new(digest).is_password?(token) unless digest.nil?
  end

  #deletes remember digest
  def forget
    update_attribute(:remember_digest,nil)
  end
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end
  def activate_account
      self.update_attribute(:activated,true)
      self.update_attribute(:activated_at,Time.zone.now)
  end
  def create_reset_digest
    self.reset_token=User.new_token
    update_attribute(:reset_digest,User.digest(reset_token))
    update_attribute(:reset_sent_time,Time.zone.now)
  end
  def send_reset_email
    UserMailer.password_reset(self).deliver_now
  end
  def password_reset_expired?
    reset_sent_time < 2.hours.ago
  end

#micropost methods
  def feed
    following_ids="SELECT followed_id FROM relationships WHERE follower_id= :user_id"
    Micropost.where("user_id IN (#{following_ids}) OR user_id=:user_id",user_id: id)
  end

  #relationships methods
  def follow(user)
    active_relationships.create(followed_id: user.id)
  end
  def following?(user)
    following.include?(user)
  end
  def unfollow(user)
    active_relationships.find_by(followed_id: user.id).destroy
  end
  def selected_followers
    followers.sample(10)
  end

  private

  def create_activation_digest
    self.activation_token=User.new_token
    self.activation_digest=User.digest(activation_token)
  end


end
