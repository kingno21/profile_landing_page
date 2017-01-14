

class ProfileController < ApplicationController
  before_action :authenticate_user!

  def index
    @tmp_skills = TemplateSkill.all
  end
end