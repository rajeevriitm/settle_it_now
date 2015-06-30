class AddResetToUsers < ActiveRecord::Migration
  def change
    add_column :users, :reset_digest, :string
    add_column :users, :reset_sent_time, :datetime
  end
end
