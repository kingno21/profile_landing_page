class SkillsController < ApplicationController

  def show
    respond_to :html
    @s = Skill.find(params[:id])
    @user = User.joins(:skills).where(skills: {skill_name: @s.skill_name}).shuffle
  end
end
