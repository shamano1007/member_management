require 'rails_helper'

RSpec.describe BusinessCareersController, type: :request do
  describe 'GET #index' do
    non_login_spec(:get, :business_careers_path)

    context 'ログイン済み' do
      login_user
      before { get business_careers_path }
      let!(:business_careers) { create_list(:business_career, 3, user_id: login_user.id) }

      it '成功すること' do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'GET #new' do
    non_login_spec(:get, :new_business_career_path)

    context 'ログイン済み' do
      login_user
      before { get new_business_career_path }

      it '成功すること' do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'POST #create' do
    non_login_spec(:post, :business_careers_path)

    context 'ログイン済み' do
      login_user
      before { post business_careers_path, params: { business_career: business_career_params } }

      context '正常な値を設定する' do
        let(:business_career_params) { attributes_for(:business_career) }

        it '成功すること' do
          expect(response).to have_http_status(:found)
          expect(response).to redirect_to(:business_careers)
        end

        it '新規作成されること' do
          business_career = login_user.business_careers
                                      .find_by!(industries: business_career_params[:industries])
          expect_model(
            business_career,
            business_career_params.merge(
              start_date: Date.parse(business_career_params[:start_date]),
              end_date: Date.parse(business_career_params[:end_date]).end_of_month
            )
          )
        end
      end

      context '異常な値を設定する' do
        let(:business_career_params) { attributes_for(:business_career, start_date: '') }

        it '成功すること' do
          expect(response).to have_http_status(:success)
        end

        it '新規作成されないこと' do
          expect(
            BusinessCareer.exists?(industries: business_career_params[:industries])
          ).to be false
        end
      end
    end
  end

  describe 'GET #edit' do
    non_login_spec(:get, :edit_business_career_path, 1)

    context 'ログイン済み' do
      login_user
      let(:business_career) { create(:business_career, industries: 'サービスAA') }
      before { get edit_business_career_path(business_career) }

      it '成功すること' do
        expect(response).to have_http_status(:success)
      end
    end
  end
  describe 'PATCH #edit' do
    non_login_spec(:patch, :business_career_path, 1)

    context 'ログイン済み' do
      login_user
      let(:business_career) { create(:business_career, industries: 'サービスAA') }
      before do
        patch(
          business_career_path(business_career),
          params: { business_career: business_career_params }
        )
      end

      context '正常な値を設定' do
        let(:business_career_params) { attributes_for(:business_career) }

        it '成功すること' do
          expect(response).to have_http_status(:found)
          expect(response).to redirect_to(:business_careers)
        end

        it '更新されること' do
          business_career.reload
          expect_model(
            business_career,
            business_career_params.merge(
              start_date: Date.parse(business_career_params[:start_date]),
              end_date: Date.parse(business_career_params[:end_date]).end_of_month
            )
          )
        end
      end

      context '異常な値' do
        let(:business_career) { create(:business_career, before_business_career) }
        let(:before_business_career) { attributes_for(:business_career, industries: 'サービスAA') }
        let(:business_career_params) { attributes_for(:business_career, start_date: '') }

        it '成功すること' do
          expect(response).to have_http_status(:success)
        end

        it '更新されないこと' do
          business_career.reload
          expect_model(
            business_career,
            before_business_career.merge(
              start_date: Date.parse(before_business_career[:start_date]),
              end_date: Date.parse(before_business_career[:end_date]).end_of_month
            )
          )
        end
      end
    end
  end
end
