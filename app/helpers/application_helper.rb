module ApplicationHelper
  def page_title
    t("#{controller_path.tr('/', '.')}.#{action_name}.title")
  end

  def nav_link(title, path, clazz: nil)
    path_controller = Rails.application.routes.recognize_path(path)[:controller]
    link_to title, path, class: "#{clazz} #{path_controller == controller_path ? 'active' : nil}"
  end

  def content_tag_if(flag, name, content_or_options_with_block = nil, options = nil, &block)
    content_tag(name, content_or_options_with_block, options, true, &block) if flag
  end

  def form_for(record, options = {}, &block)
    options[:builder] = ApplicationFormBuilder
    super(record, options, &block)
  end

  def error_messages(obj)
    return unless obj.errors.any?
    content_tag(:div, class: 'alert alert-error') do
      content_tag(:ul) do
        safe_join(obj.errors.full_messages.map { |m| content_tag(:li, m) })
      end
    end
  end
end
