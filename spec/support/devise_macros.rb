module DeviseMacros
  def login_user(params = {})
    let(:user) { create(:user, params) }
    before { sign_in user }
  end
end
