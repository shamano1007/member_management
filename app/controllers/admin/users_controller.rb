class Admin::UsersController < Admin::BaseController
  def index
    @users = User.order(:role).order(:login_id)
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

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.assign_attributes(user_params)
    if @user.save
      sign_in(@user, bypass: true) if current_user.id == @user.id
      redirect_to admin_users_path, notice: i18n_message(:update_success)
    else
      render :new
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
