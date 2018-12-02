module BusinessCareerDecorator
  def form_works
    BusinessCareer.work_columns.map do |info|
      form_html(info)
    end
  end

  def show_period
    end_label = end_date ? l(end_date, format: :month) : t(:in_continuous)
    t(:period, start: l(start_date, format: :month), end: end_label)
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
