module ButtonsHelper
  def button_name(key)
    t("buttons.#{key}")
  end
end
