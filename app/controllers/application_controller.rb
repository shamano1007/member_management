class ApplicationController < ActionController::Base
  http_basic_authenticate_with Settings.basic_auth.to_h if Rails.env.production?
  before_action :authenticate_user!

  helper_method :i18n_message

  private

  def save_process(model, success_path, error_render)
    if model.save
      redirect_to success_path, notice: i18n_message(:"#{action_name}_success")
    else
      render error_render
    end
  end

  def destroy_process(model, path)
    model&.destroy
    redirect_to path, notice: i18n_message(:destroy_success)
  end

  def i18n_message(type)
    I18n.t("messages.#{type}")
  end
end
