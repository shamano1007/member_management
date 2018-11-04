require 'rails_helper'

RSpec.describe User, type: :model do
  describe '入力チェック' do
    let(:user) { build(:user) }

    context 'ログインID' do
      check_for_required(FactoryBot.build(:user), :login_id, 'loginid')
      check_for_alphanumeric(FactoryBot.build(:user), :login_id,
                             value: 'Loginid01',
                             error_value: ['ああああああ', 'ＡＡＡＡＡＡ', '１２３４５６', 'AAAA A'])
      check_for_length_min(FactoryBot.build(:user), :login_id, 'A', min: 6)

      context '重複' do
        before { create(:user, login_id: 'loginid01') }
        validator_error(FactoryBot.build(:user, login_id: 'loginid01'), :login_id)
      end
    end

    context 'パスワード' do
      check_for_required(FactoryBot.build(:user), :login_id, 'loginid')
      check_for_alphanumeric(FactoryBot.build(:user), :login_id,
                             value: 'Password',
                             error_value: ['ああああああ', 'ＡＡＡＡＡＡ', '１２３４５６', 'AAAA A'])
      check_for_length_min(FactoryBot.build(:user, password_confirmation: 'AAAAAA'),
                           :password, 'A', min: 6)

      context '確認パスワードと一致しない' do
        validator_error(FactoryBot.build(:user, password: 'password',
                                                password_confirmation: 'loginid01'),
                        :password_confirmation)
      end
    end

    context '名前' do
      check_for_required(FactoryBot.build(:user), :name, 'なまえ')
    end
  end

  describe '#update_without_current_password' do
    let(:user) { create(:user) }
    subject { user.update_without_current_password(password_params) }

    context '正常なパスワードを設定する' do
      let(:password_params) { { password: '123456', password_confirmation: '123456' } }
      it { is_expected.to be true }
    end
    context 'パスワードを設定しない' do
      let(:password_params) { { password: '', password_confirmation: '' } }
      it { is_expected.to be false }
    end
    context '異常なパスワードを設定しない' do
      let(:password_params) { { password: 'ああ', password_confirmation: 'ああ' } }
      it { is_expected.to be false }
    end
  end
end
