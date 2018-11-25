require 'rails_helper'

RSpec.describe BusinessCareer, type: :model do
  def self.build_business_career(params = {})
    FactoryBot.build(:business_career, params.merge(user_id: 1))
  end

  describe '入力チェック' do
    before { create(:user, id: 1) }
    context '期間' do
      context '開始' do
        check_for_required(
          build_business_career(end_date: nil),
          :start_date, '2018/10'
        )
        check_for_date_month(build_business_career(end_date: nil), :start_date)
      end

      context '終了' do
        check_for_date_month(build_business_career(start_date: '2018/10'), :end_date)
      end

      context '開始 <= 終了' do
        validator_success(build_business_career(start_date: '2018/11', end_date: '2018/12'))
      end

      context '開始 > 終了' do
        let(:business_career) do
          validator_error(build_business_career(start_date: '2018/11', end_date: '2018/09'))
        end
      end
    end

    context '業種' do
      check_for_required(build_business_career, :industries, '業種')
    end

    context '概要' do
      check_for_required(build_business_career, :overview, '概要')
    end
  end
end
