module BusinessCareerDecorator
  def form_works
    Settings.business_work.map do |column|
      form_html(column)
    end
  end

  private

  def form_html(column)
    name = "work/#{column}"
    safe_join([
                check_box(:business_career, name, { checked: work&.dig(column) }, true, false),
                label(:business_career, name, self.class.human_attribute_name(name))
              ])
  end
end
