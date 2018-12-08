class Users::ProfilesController < ApplicationController
  def show
    @profile = current_user.profile || current_user.build_profile
  end

  def create
    @profile = current_user.build_profile
    @profile.assign_attributes(profile_params)
    save_process(@profile, users_profile_path, :show)
  end

  def update
    @profile = current_user.profile
    @profile.assign_attributes(profile_params)
    save_process(@profile, users_profile_path, :show)
  end

  private

  def profile_params
    params.require(:profile).permit(:birthdate, :address, :closest_line, :closest_station)
  end
end
