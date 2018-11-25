class ApplicationController < ActionController::Base
  http_basic_authenticate_with Settings.basic_auth.to_h if Rails.env.production?
  before_action :authenticate_user!

  helper_method :i18n_message

  private

  def save(model, success_path, error_render)
    if model.save
      redirect_to success_path, notice: i18n_message(:"#{action_name}_success")
    else
      render error_render
    end
  end

  def i18n_message(type)
    I18n.t("messages.#{type}")
  end
end
