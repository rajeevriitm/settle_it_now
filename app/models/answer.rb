class Answer < ActiveRecord::Base
  # after_save :answer_activity
  belongs_to :micropost
  belongs_to :user
  # has_many :activities,as: :action,dependent: :destroy
  validates :response,presence: true
  validates :user_id,presence: true
  validates :micropost_id,presence: true
  default_scope -> {order(created_at: :desc)}

  # ActiveRecord::Base.transaction do
  #   def answer_activity
  #     activities.create!(owner_id: user_id,user_id: user_id,micropost_id: micropost_id)
  #     user.followers.each do |follower|
  #       activities.create!(owner_id: user_id,user_id: follower.id,micropost_id: micropost_id)
  #     end
  #   end
  # end

end
