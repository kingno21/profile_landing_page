class SkillsController < ApplicationController

  def show
    respond_to :html
    @s = Skill.find(params[:id])
    @user = User.includes(:skills).where(skills: { skill_name: @s.skill_name })
    @liked_user = LikedUser.joins(:skill).where(skills: {skill_name: @s.skill_name})
  end
end
