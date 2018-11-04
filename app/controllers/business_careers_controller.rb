class BusinessCareersController < ApplicationController
  def index
    @business_careers = current_user.business_careers
  end
end
