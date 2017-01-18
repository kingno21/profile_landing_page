# == Schema Information
#
# Table name: skills
#
#  id            :integer          not null, primary key
#  skill_name    :string
#  user_id       :integer
#  like_count    :integer          default("0")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  added_user_id :integer
#

require 'test_helper'

class SkillTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
