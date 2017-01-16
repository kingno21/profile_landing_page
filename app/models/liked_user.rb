# == Schema Information
#
# Table name: liked_users
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  skill_id   :integer
#  user_id    :integer
#

class LikedUser < ApplicationRecord
  belongs_to :skill
  belongs_to :user

  validates :user_id, uniqueness: { scope: [:skill_id] }

  def format_user
    {
      user_id: user_id,
      user_name: user.name
    }
  end
end
