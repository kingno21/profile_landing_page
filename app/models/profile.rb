# == Schema Information
#
# Table name: profiles
#
#  id         :integer          not null, primary key
#  user_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Profile < ApplicationRecord
  belongs_to :user

end
