require 'rails_helper'

RSpec.describe Users::ProfilesController, type: :request do
  describe 'GET #show' do
    non_login_spec(:get, :users_profile_path)

    context 'ログイン済み' do
      login_user
      before { get users_profile_path }

      it '成功すること' do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'POST #create' do
    non_login_spec(:post, :users_profile_path)

    context 'ログイン済み' do
      login_user
      before { post users_profile_path, params: { profile: profile_params } }

      context '正常な値を設定する' do
        let(:profile_params) { attributes_for(:profile) }

        it '成功すること' do
          expect(response).to have_http_status(:found)
          expect(response).to redirect_to(:users_profile)
        end

        it 'プロフィールが新規作成されること' do
          profile = Profile.find_by!(user_id: login_user.id)
          expect_model(
            profile,
            profile_params.merge(
              birthdate: profile_params[:birthdate].to_date,
              user_id: login_user.id
            ),
            %i[user_id birthdate address closest_line closest_station]
          )
        end
      end

      context '異常な値を設定する' do
        let(:profile_params) { attributes_for(:profile, birthdate: '1991/13/1') }

        it '成功すること' do
          expect(response).to have_http_status(:success)
        end

        it 'プロフィールが新規作成されないこと' do
          expect(Profile.exists?(user_id: login_user.id)).to be false
        end
      end
    end
  end

  describe 'PATCH #update' do
    non_login_spec(:patch, :users_profile_path)

    context 'ログイン済み' do
      login_user
      let(:before_profile) { attributes_for(:profile, user_id: login_user.id) }
      let!(:profile) { create(:profile, before_profile) }
      before { patch users_profile_path, params: { profile: profile_params } }

      context '正常な値を設定' do
        let(:profile_params) { attributes_for(:profile) }

        it '成功すること' do
          expect(response).to have_http_status(:found)
          expect(response).to redirect_to(:users_profile)
        end

        it 'プロフィールが更新されること' do
          profile.reload
          expect_model(
            profile,
            profile_params.merge(birthdate: profile_params[:birthdate].to_date),
            %i[birthdate address closest_line closest_station]
          )
        end
      end

      context '異常な値' do
        let(:profile_params) { attributes_for(:profile, birthdate: '1991/13/1') }

        it '成功すること' do
          expect(response).to have_http_status(:success)
        end

        it 'プロフィールが更新されないこと' do
          profile.reload
          expect_model(
            profile,
            before_profile.merge(birthdate: before_profile[:birthdate].to_date),
            %i[user_id birthdate address closest_line closest_station]
          )
        end
      end
    end
  end
end
