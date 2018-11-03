class Users::PasswordsController < ApplicationController
  def update
    return unless current_user.update_without_current_password(password_params)

    sign_in(current_user, bypass: true)
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
