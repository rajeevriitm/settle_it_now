  class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.references :user, index: true, foreign_key: true
      t.references :action, index: true, polymorphic: true
      t.references :micropost, index: true, foreign_key: true
      t.references :owner,index:true,foreign_key: true
      t.timestamps null: false
    end
    add_index :activities,:action_id
  end
end
