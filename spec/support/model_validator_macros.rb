module ModelValidatorMacros
  def check_for_required(model, column, value)
    context '未入力' do
      before { model.public_send("#{column}=", '') }
      validator_error(model, column)
    end
    context '入力済み' do
      before { model.public_send("#{column}=", value) }
      validator_success(model)
    end
  end

  def check_for_alphanumeric(model, column, value:, error_value:)
    error_value.flatten.each do |e_v|
      context "半角英数字以外：#{e_v}" do
        before { model.public_send("#{column}=", e_v) }
        validator_error(model, column)
      end
    end
    context '半角英数字' do
      before { model.public_send("#{column}=", value) }
      validator_success(model)
    end
  end

  def validator_error(model, column)
    it 'エラーになること' do
      expect(model.valid?).to be false
      expect(model.errors[column]).to be_present
    end
  end

  private

  def validator_success(model)
    it 'エラーにならないこと' do
      expect(model.valid?).to be true
    end
  end
end
