class ApplicationFormBuilder < ActionView::Helpers::FormBuilder
  def line_field(label, &block)
    content_tag(:div, class: 'form-group row') do
      safe_join([content_label(label), content_tag(:div, block.call(self), class: 'col-10')])
    end
  end

  def create_or_update_submit
    submit(@template.button_name(:create), class: 'btn btn-create')
  end

  private

  def content_label(label)
    content_tag(:label, @object.class.human_attribute_name(label), class: 'col-2 col-form-label')
  end

  def content_tag(name, content_or_options_with_block = nil, options = nil, &block)
    @template.content_tag(name, content_or_options_with_block, options, true, &block)
  end

  def safe_join(contents)
    @template.safe_join(contents)
  end
end
