class TemplateSkillController < ApplicationController
  def index
    @template_skills = TemplateSkill.all.order(:id)
  end

  def create
    respond_to do |format|
      @new_tmp = TemplateSkill.create(set_params)
      if !@new_tmp.errors.any?
        format.json { render json: @new_tmp }
      else
        format.json { render json: false }
      end
    end
  end

  private
  def set_params
    params.require(:template_skill).permit(:skill_name, :short_form)
  end
end
