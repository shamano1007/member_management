# 日付バリデーション
# date: true
# options =>
#   blank: true => ブランク許可
class DateValidator < Base
  def validate_each(record, attribute, _value)
    value = record.public_send("#{attribute}_before_type_cast")
    return if options[:blank] && before_value.blank?

    record.errors.add(attribute, :date) unless [valid_format?(value), date_valid?(value)].all?
  end

  private

  def date_valid?(str)
    !Date.parse(str).nil?
  rescue StandardError
    false
  end
end
