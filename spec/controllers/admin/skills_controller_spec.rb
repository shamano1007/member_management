require 'rails_helper'

RSpec.describe Admin::SkillsController, type: :request do
  describe 'GET #index' do
    non_login_spec(:get, :admin_skills_path)
    non_admin_user_spec(:get, :admin_skills_path)

    context 'ログイン済み' do
      login_user(admin: true)
      before { get admin_skills_path }

      it '成功すること' do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'GET #new' do
    non_login_spec(:get, :new_admin_skill_path)
    non_admin_user_spec(:get, :new_admin_skill_path)

    context 'ログイン済み' do
      login_user(admin: true)
      before { get new_admin_skill_path }

      it '成功すること' do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'POST #create' do
    non_login_spec(:post, :admin_skills_path)
    non_admin_user_spec(:post, :admin_skills_path)

    context 'ログイン済み' do
      login_user(admin: true)
      before { post admin_skills_path, params: { skill: skill_params } }

      context '正常な値を設定する' do
        let(:skill_params) { attributes_for(:skill) }

        it '成功すること' do
          expect(response).to have_http_status(:found)
          expect(response).to redirect_to(:admin_skills)
        end

        it 'スキルが新規作成されること' do
          skill = Skill.find_by!(name: skill_params[:name])
          expect_model(skill, skill_params, %i[remarks])
        end
      end

      context '異常な値を設定する' do
        let(:skill_params) { attributes_for(:skill, name: '') }

        it '成功すること' do
          expect(response).to have_http_status(:success)
        end

        it 'スキルが新規作成されないこと' do
          expect(Skill.exists?(name: skill_params[:name])).to be false
        end
      end
    end
  end

  describe 'GET #edit' do
    non_login_spec(:get, :edit_admin_skill_path, 1)
    non_admin_user_spec(:get, :edit_admin_skill_path, 1)

    context 'ログイン済み' do
      login_user(admin: true)
      let(:skill) { create(:skill, name: 'editSkill') }

      before { get edit_admin_skill_path(skill) }

      it '成功すること' do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'PATCH #edit' do
    non_login_spec(:patch, :admin_skill_path, 1)
    non_admin_user_spec(:patch, :admin_skill_path, 1)

    context 'ログイン済み' do
      login_user(admin: true)
      let(:skill) { create(:skill, name: 'スキル', remarks: '備考') }
      before { patch admin_skill_path(skill), params: { skill: skill_params } }

      context '正常な値を設定' do
        let(:skill_params) { attributes_for(:skill) }

        it '成功すること' do
          expect(response).to have_http_status(:found)
          expect(response).to redirect_to(:admin_skills)
        end

        it 'スキルが更新されること' do
          skill.reload
          expect_model(skill, skill_params, %i[name remarks])
        end
      end

      context '異常な値' do
        let(:skill_params) { attributes_for(:skill, name: '') }

        it '成功すること' do
          expect(response).to have_http_status(:success)
        end

        it 'スキルが更新されないこと' do
          skill.reload
          expect_model(skill, { name: 'スキル', remarks: '備考' }, %i[name remarks])
        end
      end
    end
  end

  describe 'delete #destroy' do
    non_login_spec(:delete, :admin_skill_path, 1)
    non_admin_user_spec(:delete, :admin_skill_path, 1)

    context 'ログイン済み' do
      login_user(admin: true)
      let!(:skill1) { create(:skill, name: 'deleteSkill1') }
      let!(:skill2) { create(:skill, name: 'deleteSkill2') }
      context 'スキルを削除' do
        before { delete admin_skill_path(skill2) }
        it '削除されること' do
          expect(Skill.exists?(id: skill1.id)).to be true
          expect(Skill.exists?(id: skill2.id)).to be false
        end
      end
    end
  end
end
