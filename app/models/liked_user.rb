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

end
