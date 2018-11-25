class BusinessCareersController < ApplicationController
  before_action :load_business_career, only: %i[edit update]

  def index
    @business_careers = current_user.business_careers
  end

  def new
    @business_career = current_user.business_careers.build
  end

  def create
    @business_career = current_user.business_careers.build(business_career_params)
    save(@business_career, business_careers_path, :new)
  end

  def edit; end

  def update
    @business_career.assign_attributes(business_career_params)
    save(@business_career, business_careers_path, :edit)
  end

  private

  def load_business_career
    @business_career = current_user.business_careers.find(params[:id])
  end

  def business_career_params
    params.require(:business_career)
          .permit(
            :start_date, :end_date, :industries, :overview, :role, :memo,
            *BusinessCareer.work_columns.map { |o| o[:name] }
          )
  end
end
