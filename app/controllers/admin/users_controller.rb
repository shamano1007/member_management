class Admin::UsersController < Admin::BaseController
  def index
    @users = User.order(:login_id)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: i18n_message(:create_success)
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:login_id, :name, :role, :password, :password_confirmation)
  end
end
