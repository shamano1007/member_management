class Admin::UsersController < Admin::BaseController
  def index
    @users = User.order(:role).order(:login_id)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    save_process(@user, admin_users_path, :new)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.assign_attributes(user_params)
    save_process(@user, admin_users_path, :edit) do
      bypass_sign_in(@user) if current_user.id == @user.id
    end
  end

  def destroy
    unless current_user.id == params[:id].to_i
      user = User.find_by(id: params[:id])
      user&.destroy
    end
    redirect_to admin_users_path, notice: i18n_message(:destroy_success)
  end

  private

  def user_params
    params.require(:user).permit(:login_id, :name, :role, :password, :password_confirmation)
  end
end
