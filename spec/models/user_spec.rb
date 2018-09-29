require 'rails_helper'

RSpec.describe User, type: :model do
  describe '入力チェック' do
    let(:user) { build(:user) }

    context 'ログインID' do
      check_for_required(FactoryBot.build(:user), :login_id, 'loginid')
      check_for_alphanumeric(FactoryBot.build(:user), :login_id,
                             value: 'loginid01',
                             error_value: ['ああああああ', 'ＡＡＡＡＡＡ', '１２３４５６', 'AAAA A'])
      context '重複' do
        before { create(:user, login_id: 'loginid01') }
        validator_error(FactoryBot.build(:user, login_id: 'loginid01'), :login_id)
      end
    end

    context 'パスワード' do
      check_for_required(FactoryBot.build(:user), :login_id, 'loginid')
      check_for_alphanumeric(FactoryBot.build(:user), :login_id,
                             value: 'password',
                             error_value: ['ああああああ', 'ＡＡＡＡＡＡ', '１２３４５６', 'AAAA A'])
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
end
