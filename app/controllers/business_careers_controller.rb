class BusinessCareersController < ApplicationController
  def index
    @business_careers = current_user.business_careers
  end

  def new
    @business_career = current_user.business_careers.build
  end

  def create
    @business_career = current_user.business_careers.build(business_career_params)
    if @business_career.save
      redirect_to business_careers_path, notice: i18n_message(:create_success)
    else
      render :new
    end
  end

  private

  def business_career_params
    params.require(:business_career)
          .permit(:start_date, :end_date, :industries, :overview, :role, :memo)
  end
end
