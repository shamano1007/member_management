class Admin::Skills::VersionsController < Admin::BaseController
  before_action :load_skill
  before_action :setting_title_option

  def show; end

  private

  def setting_title_option
    page_title_options({ skill: @skill.name })
  end

  def load_skill
    @skill = Skill.find(params[:skill_id])
    @skill_versions = @skill.versions
  end
end
