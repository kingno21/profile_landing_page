class Skill < ApplicationRecord
  belongs_to :user
  has_many :liked_user

end
