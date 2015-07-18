class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.references :micropost, index: true, foreign_key: true
      t.text :response
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :answers,:response
  end
end
