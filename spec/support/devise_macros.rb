module DeviseMacros
  def login_user(params = {})
    let(:login_user) { create(:user, params) }
    before { sign_in login_user }
  end

  def non_login_spec
    context '未済み' do
      before { get root_path }

      it 'リダイレクトされること' do
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(:new_user_session)
      end
    end
  end
end
