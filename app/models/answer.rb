class Answer < ActiveRecord::Base
  belongs_to :micropost
  belongs_to :user
  validates :response,presence: true
  validates :user_id,presence: true
  validates :micropost_id,presence: true
  default_scope -> {order(created_at: :desc)}
end
