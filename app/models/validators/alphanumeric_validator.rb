# 英数字バリデーション
# alphanumeric: true
class AlphanumericValidator < Base
  def validate_each(record, attribute, value)
    return if value.blank?

    record.errors.add(attribute, :alphanumeric) unless valid_format?(value)
  end
end
