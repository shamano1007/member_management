class Admin::SkillsController < Admin::BaseController
  def index
    @skills = Skill.order(:name)
  end

  def new
    @skill = Skill.new
  end

  def create
    @skill = Skill.new(skill_params)
    save_process(@skill, admin_skills_path, :new)
  end

  def edit
    @skill = Skill.find(params[:id])
  end

  def update
    @skill = Skill.find(params[:id])
    @skill.assign_attributes(skill_params)
    save_process(@skill, admin_skills_path, :edit)
  end

  def destroy
    skill = Skill.find_by(id: params[:id])
    skill&.destroy
    redirect_to admin_skills_path, notice: i18n_message(:destroy_success)
  end

  private

  def skill_params
    params.require(:skill).permit(:name, :remarks)
  end
end
