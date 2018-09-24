require 'rails_helper'

RSpec.describe HomeController, type: :request do
  describe 'GET #show' do
    non_login_spec

    context 'ログイン済み' do
      login_user
      before { get root_path }

      it '成功すること' do
        expect(response).to have_http_status(:success)
      end
    end
  end
end
