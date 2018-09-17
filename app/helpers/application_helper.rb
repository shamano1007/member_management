module ApplicationHelper
  def page_title
    t("#{controller_path.tr('/', '.')}.#{action_name}.title")
  end

  def content_tag_if(flag, name, content_or_options_with_block = nil, options = nil, &block)
    content_tag(name, content_or_options_with_block, options, true, &block) if flag
  end
end
