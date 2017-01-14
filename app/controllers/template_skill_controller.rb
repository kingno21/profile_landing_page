class TemplateSkillController < ApplicationController
  def index
    @template_skills = TemplateSkill.all.order(:id)
  end

  def create
    @new_tmp = TemplateSkill.create(set_params)
    respond_to do |format|
      if @new_tmp.save
        format.html { redirect_to :back }
      else
        format.html { redirect_to :back }
      end

    end
  end

  private
  def set_params
    params.require(:template_skill).permit(:skill_name, :short_form)
  end
end
