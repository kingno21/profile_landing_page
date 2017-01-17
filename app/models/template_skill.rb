# == Schema Information
#
# Table name: template_skills
#
#  id         :integer          not null, primary key
#  skill_name :string
#  short_form :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TemplateSkill < ApplicationRecord
  validates :skill_name, uniqueness: true

end
