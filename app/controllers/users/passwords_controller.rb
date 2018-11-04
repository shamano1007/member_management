class Users::PasswordsController < ApplicationController
  def update
    return unless current_user.update_without_current_password(password_params)

    bypass_sign_in(current_user)
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
