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
    non_login_spec(:post, :admin_users_path)

    context 'ログイン済み' do
      let(:user_params) { attributes_for(:user) }

      login_user
      before { post admin_users_path, params: { user: user_params } }

      it '成功すること' do
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(:admin_users)
      end

      it 'ユーザーが新規作成されること' do
        user = User.find_by!(login_id: user_params[:login_id])
        expect_model(user, user_params, %i[name role])
        expect(user.valid_password?(user_params[:password])).to be true
      end
    end
  end

  describe 'GET #edit' do
    non_login_spec(:get, :edit_admin_user_path, 1)

    context 'ログイン済み' do
      let(:user) { create(:user, login_id: 'editUser') }

      login_user
      before { get edit_admin_user_path(user) }

      it '成功すること' do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'PATCH #edit' do
    non_login_spec(:patch, :admin_user_path, 1)

    context 'ログイン済み' do
      let(:user) { create(:user, login_id: 'editUser', password: 'password001') }
      login_user
      before { patch admin_user_path(user), params: { user: user_params } }

      context 'パスワードを変更しない' do
        let(:user_params) { attributes_for(:user, password: nil) }

        it '成功すること' do
          expect(response).to have_http_status(:found)
          expect(response).to redirect_to(:admin_users)
        end

        it 'ユーザーが更新されること' do
          user.reload
          expect_model(user, user_params, %i[name login_id role])
          expect(user.valid_password?('password001')).to be true
        end
      end

      context 'パスワードを変更する' do
        let(:user_params) { attributes_for(:user, password: 'password002') }

        it '成功すること' do
          expect(response).to have_http_status(:found)
          expect(response).to redirect_to(:admin_users)
        end

        it 'ユーザーが更新されること' do
          user.reload
          expect_model(user, user_params, %i[name login_id role])
          expect(user.valid_password?('password002')).to be true
        end
      end

      context 'パスワードを設定しない' do
        let(:user_params) { attributes_for(:user, password: '', password_confirmation: 'aaaaaa') }

        it '成功すること' do
          expect(response).to have_http_status(:success)
          expect(request.path).to eq admin_user_path(user)
        end

        it 'ユーザーが更新されないこと' do
          user_tmp = User.find(user.id)
          expect(user.attributes).to eq user_tmp.attributes
        end
      end

      context '確認パスワードを設定しない' do
        let(:user_params) { attributes_for(:user, password_confirmation: '') }

        it '成功すること' do
          expect(response).to have_http_status(:success)
          expect(request.path).to eq admin_user_path(user)
        end

        it 'ユーザーが更新されないこと' do
          user_tmp = User.find(user.id)
          expect(user.attributes).to eq user_tmp.attributes
        end
      end
    end
  end
end
