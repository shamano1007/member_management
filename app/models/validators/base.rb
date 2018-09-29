class Base < ActiveModel::EachValidator
  private

  def valid_format?(value)
    setting.format =~ value
  end

  def setting
    @setting ||= Settings.validators[self.class.name.underscore.to_sym]
  end
end
