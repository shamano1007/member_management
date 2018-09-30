class Admin::BaseController < ApplicationController
  before_action :authenticate_admin_user!

  private

  def authenticate_admin_user!
    redirect_to root_path and return unless current_user.role.admin?
  end
end
