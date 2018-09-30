require 'rails_helper'

RSpec.describe Admin::UsersController, type: :request do
  describe 'GET #index' do
    non_login_spec(:get, :admin_users_path)

    context 'ログイン済み' do
      login_user
      before { get admin_users_path }

      it '成功すること' do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'GET #new' do
    non_login_spec(:get, :new_admin_user_path)

    context 'ログイン済み' do
      login_user
      before { get new_admin_user_path }

      it '成功すること' do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'POST #create' do
    let(:user_params) do
      user_attributes = attributes_for(:user)
      user_attributes.merge(password_confirmation: user_attributes[:password])
    end

    non_login_spec(:post, :admin_users_path)

    context 'ログイン済み' do
      login_user

      before { post admin_users_path, params: { user: user_params } }

      it '成功すること' do
        expect(response).to have_http_status(:success)
      end

      it 'ユーザーが新規作成されること' do
        user = User.find_by!(login_id: user_params[:login_id])
        expect_model(user, user_params, %i[name])
      end
    end
  end
end
