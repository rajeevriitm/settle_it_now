class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :action,polymorphic: true
  belongs_to :micropost
  belongs_to :owner,class_name: "User"
  validates :user_id , presence: true
  validates :micropost_id , presence: true
  validates :action_id , presence: true
  validates :action_type , presence: true
  validates :owner_id , presence: true
  default_scope -> {order(created_at: :desc)}

end
