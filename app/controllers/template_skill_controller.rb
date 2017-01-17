class TemplateSkillController < ApplicationController
  def index
    @template_skills = TemplateSkill.all.order(:id)
  end

  def create
    @new_tmp = TemplateSkill.create(set_params)
    respond_to do |format|
      format.json { render json: @new_tmp }
    end
  end

  private
  def set_params
    params.require(:template_skill).permit(:skill_name, :short_form)
  end
end
