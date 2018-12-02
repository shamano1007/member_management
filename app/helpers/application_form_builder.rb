class ApplicationFormBuilder < ActionView::Helpers::FormBuilder
  # TODO: ブロックの渡し方 do ~ end の場合、意図しない動きをする
  def line_field(label, req: false)
    content_tag(:div, class: 'form-group row') do
      safe_join([
                  content_label(label, req: req),
                  content_tag(:div, yield(self), class: "col-#{options[:field_col]}")
                ])
    end
  end

  def content_label(label, req: false)
    content_tag(:label,
                @object.class.human_attribute_name(label),
                class: "col-#{options[:label_col]} col-form-label #{'required' if req}")
  end

  def create_or_update_submit
    key = @object.new_record? ? :create : :update
    submit(@template.button_name(key), class: "btn btn-#{key}")
  end

  def text_field_month(method, options = {})
    options[:value] = I18n.l(@object[method], format: :month) if @object[method]
    text_field(method, options)
  end

  def text_field(method, options = {})
    options[:placeholder] ||= placeholder_text(method)
    super(method, options)
  end

  def text_area(method, options = {})
    options[:placeholder] ||= placeholder_text(method)
    super(method, options)
  end

  private

  def placeholder_text(method)
    I18n.t(
      "#{@object.class.i18n_scope}.placeholders.#{@object.model_name.i18n_key}.#{method}",
      default: ''
    )
  end

  def content_tag(name, content_or_options_with_block = nil, options = nil, &block)
    @template.content_tag(name, content_or_options_with_block, options, true, &block)
  end

  def safe_join(contents)
    @template.safe_join(contents)
  end
end
