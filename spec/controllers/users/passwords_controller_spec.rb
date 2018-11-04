require 'rails_helper'

RSpec.describe Users::PasswordsController, type: :request do
  describe 'PATCH #update' do
    non_login_spec(:patch, :users_password_path)

    context 'ログイン済み' do
      login_user(password: '123456', password_confirmation: '123456')
      before do
        patch users_password_path,
              params: { user: password_params },
              headers: { accept: 'application/javascript' }
      end

      context '正常な値を設定' do
        let(:password_params) { { password: 'asdfgh', password_confirmation: 'asdfgh' } }

        it '成功すること' do
          expect(response).to have_http_status(:success)
        end

        it 'パスワードが更新されること' do
          login_user.reload
          expect(login_user.valid_password?('asdfgh')).to be true
        end
      end

      context '異常な値' do
        let(:password_params) { { password: 'a', password_confirmation: 'as' } }

        it '成功すること' do
          expect(response).to have_http_status(:success)
        end

        it 'パスワードが更新されないこと' do
          login_user.reload
          expect(login_user.valid_password?('123456')).to be true
        end
      end
    end
  end
end
