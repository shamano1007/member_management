# 年月バリデーション
# month: true
# options =>
#   blank: true => ブランク許可
class MonthValidator < Base
  def validate_each(record, attribute, _value)
    value = record.public_send("#{attribute}_before_type_cast")
    return if options[:blank] && value.blank?

    if [valid_format?(value, exclusion: Date), date_valid?(value)].all?
      record[attribute] = registration_value(value, attribute)
    else
      record.errors.add(attribute, :month)
    end
  end

  private

  def registration_value(value, attribute)
    value = Date.parse("#{value}/01")
    value = value.end_of_month if attribute.to_s.include?('end')
    value
  end

  def date_valid?(str)
    !Date.parse("#{str}/01").nil?
  rescue StandardError
    false
  end
end
