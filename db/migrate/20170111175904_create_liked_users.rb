class CreateLikedUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :liked_users do |t|

      t.timestamps
      t.references :skills
      t.integer :user_id
    end
  end
end
