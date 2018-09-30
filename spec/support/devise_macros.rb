module DeviseMacros
  def login_user(params = {})
    let(:login_user) { create(:user, params) }
    before { sign_in login_user }
  end

  def non_login_spec(method, path)
    context '未済み' do
      before do
        public_send(method, Rails.application.routes.url_helpers.public_send(path))
      end

      it 'リダイレクトされること' do
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(:new_user_session)
      end
    end
  end
end
