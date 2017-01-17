

class ProfilesController < ApplicationController
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
          @s = Skill.create(user_id: user.id, skill_name: ts.skill_name, like_count: 0, added_user_id: params[:added_user_id]).format_skill.to_json
          format.js
        end
      end
    end
  end

  def update_like
    respond_to do |format|
      if LikedUser.find_by(skill_id: params[:skill_id], user_id: params[:user_id])
        LikedUser.find_by(skill_id: params[:skill_id], user_id: params[:user_id]).destroy
        format.json { render json: Skill.find(params[:skill_id]).format_skill }
      else
        liked_user = LikedUser.create(skill_id: params[:skill_id], user_id: params[:user_id])
        format.json { render json: liked_user.skill.format_skill }
      end
    end

  end

  def search
    if User.find_by(name: params[:profile][:q])
      redirect_to action: :show, id: User.find_by(name: params[:profile][:q])
    else
      render file: 'public/404.html'
    end
  end

  def init
    @tmp_skills = TemplateSkill.all.to_json
    @skills = @profile.user.skills.map {|s| s.format_skill}.to_json

  end

end

