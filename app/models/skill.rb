# == Schema Information
#
# Table name: skills
#
#  id         :integer          not null, primary key
#  skill_name :string
#  user_id    :integer
#  like_count :integer          default("0")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Skill < ApplicationRecord
  belongs_to :user
  has_many :liked_user

  def format_skill
    {
        id: id,
        skill_name: skill_name,
        user_id: user_id,
        like_count: like_count
    }
  end
end
