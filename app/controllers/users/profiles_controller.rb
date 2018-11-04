class Users::ProfilesController < ApplicationController
  def show
    @profile = current_user.profile || current_user.build_profile
  end

  def create
    @profile = current_user.build_profile
    @profile.assign_attributes(profile_params)
    if @profile.save
      redirect_to users_profile_path, notice: i18n_message(:create_success)
    else
      render :show
    end
  end

  def update
    @profile = current_user.profile
    @profile.assign_attributes(profile_params)
    if @profile.save
      redirect_to users_profile_path, notice: i18n_message(:update_success)
    else
      render :show
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:birthdate, :address, :closest_line, :closest_station)
  end
end
