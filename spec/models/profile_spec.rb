require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe '入力チェック' do
    context '生年月日' do
      before { create(:user, id: 1) }
      check_for_required(FactoryBot.build(:profile, user_id: 1), :birthdate, '1991/10/7')
      check_for_date(FactoryBot.build(:profile, user_id: 1), :birthdate)
    end
  end
end
