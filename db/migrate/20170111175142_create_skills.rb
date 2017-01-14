class CreateSkills < ActiveRecord::Migration[5.0]
  def change
    create_table :skills do |t|

	  t.string :skill_name
	  t.integer :user_id, index: true
	  t.integer :like_count, default: 0
      t.timestamps
    end
  end
end
