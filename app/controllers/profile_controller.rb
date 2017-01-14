

class ProfileController < ApplicationController
  before_action :authenticate_user!

  def index
    @profile = Profile.find_by(user_id: current_user.id)
    skills = @profile.user.skills
    @tmp_skills = TemplateSkill.all
    respond_to do |format|
      format.html
      format.json { render json: { skills: skills } }
    end

  end

  def update_profile
    respond_to do |format|
      user = Profile.find(params[:profile_id]).user
      if params[:template_skill_id]
        ts = TemplateSkill.find(params[:template_skill_id])
        if Skill.find_by(user_id: user.id, skill_name: ts.skill_name)
          format.js { render js: ''}
        else
          @s = Skill.find_or_create_by(user_id: user.id, skill_name: ts.skill_name, like_count: 0).format_skill.to_json
          format.js
        end
      end
    end
  end

end

