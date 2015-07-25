class Micropost < ActiveRecord::Base
  # after_save :micropost_activity
  belongs_to :user
  has_many :answers,dependent: :destroy
  # has_many :activities,as: :action,dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  validates :user_id,presence:true
  validates :content, presence: true
  mount_uploader :picture,PictureUploader
  validate :picture_size

  # ActiveRecord::Base.transaction do
  #   def micropost_activity
  #     activities.create!(owner_id: user_id,user_id: user_id,micropost_id: id)
  #     user.followers.each do |follower|
  #       activities.create!(owner_id: user_id,user_id: follower.id,micropost_id: id)
  #     end
  #   end
  # end

  private
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture,"should be less than 5mb")
    end
  end
end
