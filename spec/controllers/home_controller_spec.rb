require 'rails_helper'

RSpec.describe HomeController, type: :request do
  describe 'GET #show' do
    context 'ログイン済み' do
      login_user
      before { get root_path }

      it '成功すること' do
        expect(response).to have_http_status(:success)
      end
    end

    context '未済み' do
      before { get root_path }

      it 'リダイレクトされること' do
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(:new_user_session)
      end
    end
  end
end
