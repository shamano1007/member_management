require 'rails_helper'

RSpec.describe Admin::UsersController, type: :request do
  describe 'GET #index' do
    non_login_spec

    context 'ログイン済み' do
      login_user
      before { get admin_users_path }

      it '成功すること' do
        expect(response).to have_http_status(:success)
      end
    end
  end
end
