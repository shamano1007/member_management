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

  def check_for_length_min(model, column, one_value, min:)
    context "#{min}桁未満" do
      before { model.public_send("#{column}=", one_value * (min - 1)) }
      validator_error(model, column)
    end
    context "#{min}桁以上" do
      before { model.public_send("#{column}=", one_value * min) }
      validator_success(model)
    end
  end

  def check_for_length_max(model, column, one_value, max:)
    context "#{max}より大きい" do
      before { model.public_send("#{column}=", one_value * (max + 1)) }
      validator_error(model, column)
    end
    context "#{max}桁以下" do
      before { model.public_send("#{column}=", one_value * max) }
      validator_success(model)
    end
  end

  def check_for_date(model, column)
    context '正しい日付' do
      before { model.public_send("#{column}=", '1991/10/7') }
      validator_success(model)
    end
    context '不正な日付フォーマット' do
      before { model.public_send("#{column}=", 'aaaa/aa/aa') }
      validator_error(model, column)
    end
    context '不正な日付' do
      before { model.public_send("#{column}=", '1991/10/32') }
      validator_error(model, column)
    end
  end

  def check_for_date_month(model, column)
    context '正しい日付' do
      before { model.public_send("#{column}=", '2018/10') }
      validator_success(model)
    end
    context '不正な日付フォーマット' do
      before { model.public_send("#{column}=", 'aaaa/aa') }
      validator_error(model, column)
    end
    context '不正な日付' do
      before { model.public_send("#{column}=", '2018/13') }
      validator_error(model, column)
    end
  end

  def validator_error(model, column)
    it 'エラーになること' do
      expect(model.valid?).to be false
      expect(model.errors[column]).to be_present
    end
  end

  def validator_success(model)
    it 'エラーにならないこと' do
      expect(model.valid?).to be true
    end
  end
end
