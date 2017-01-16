

class ProfileController < ApplicationController
  before_action :authenticate_user!

  def index
    respond_to do |format|
      @profile = Profile.find_by(user_id: current_user.id)
      init
      format.html
    end

  end

  def show
    respond_to do |format|
      @profile = Profile.find_by(user_id: params[:id])
      init
      format.html
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

  def update_like
    respond_to do |format|
      liked_user = LikedUser.find_or_create_by(skill_id: params[:skill_id], user_id: params[:user_id])
      format.json { render json: liked_user.skill.format_skill }
    end

  end

  def search
    if User.find_by(name: params[:profile][:q])
      redirect_to action: :show, id: User.find_by(name: params[:profile][:q])
    else
      redirect_to root_path
    end
  end

  def init
    @tmp_skills = TemplateSkill.all
    @skills = @profile.user.skills.order(like_count: :desc).map {|s| s.format_skill}.to_json

  end

end

