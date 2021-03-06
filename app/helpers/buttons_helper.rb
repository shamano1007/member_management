module ButtonsHelper
  def button_name(key)
    t("buttons.#{key}")
  end

  def new_button(path)
    link_to button_name(:new), path, class: 'btn btn-new m-bottom-10'
  end

  def edit_button(path)
    link_to button_name(:edit), path, class: 'btn btn-edit'
  end

  def destroy_button(path)
    link_to button_name(:destroy), path, class: 'btn btn-destroy', method: :delete,
                                         data: { confirm: t('messages.destroy_confirm') }
  end

  def back_button(path)
    link_to button_name(:back), path, class: 'btn btn-back'
  end
end
