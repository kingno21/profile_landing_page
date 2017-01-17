class AddAddedUserIdToSkills < ActiveRecord::Migration[5.0]
  def change
      add_column :skills, :added_user_id, :integer
  end
end
