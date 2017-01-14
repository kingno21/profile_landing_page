class CreateTemplateSkills < ActiveRecord::Migration[5.0]
  def change
    create_table :template_skills do |t|

      t.string :skill_name
      t.string :short_form
      t.timestamps
    end
  end
end
