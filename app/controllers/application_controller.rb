class ApplicationController < ActionController::Base
  http_basic_authenticate_with Settings.basic_auth.to_h if Rails.env.production?
  before_action :authenticate_user!
end
