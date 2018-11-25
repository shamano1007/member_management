module BusinessCareerDecorator
  def form_works
    BusinessCareer.work_columns.map do |info|
      form_html(info)
    end
  end

  private

  def form_html(info)
    safe_join([
                check_box(
                  :business_career, info[:name],
                  { checked: work&.dig(info[:column]) },
                  true, false
                ),
                label(:business_career, info[:name], self.class.human_attribute_name(info[:name]))
              ])
  end
end
