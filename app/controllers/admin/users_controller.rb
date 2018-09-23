class Admin::UsersController < Admin::BaseController
  def index
    @users = User.order(:login_id)
  end
end
