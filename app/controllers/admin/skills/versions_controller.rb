class Admin::Skills::VersionsController < Admin::BaseController
  before_action :load_skill
  before_action :setting_title_option

  def show
    @skill_versions = @skill.versions.order(:version)
  end

  def update
    @skill_versions = @skill.versions.order(:version)
    p version_params
    render :show
  end

  private

  def version_params
    params.require(:skill).permit(versions_attributes: %i[id version remarks])
  end

  def setting_title_option
    page_title_options({ skill: @skill.name })
  end

  def load_skill
    @skill = Skill.find(params[:skill_id])
  end
end
