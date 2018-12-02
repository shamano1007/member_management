require 'rails_helper'

RSpec.describe BusinessCareerDecorator, type: :decorator do
  describe do
    let(:business_career) { BusinessCareer.new.extend BusinessCareerDecorator }
    subject { business_career }
    it { is_expected.to be_a BusinessCareer }
  end

  let(:business_career) { ActiveDecorator::Decorator.instance.decorate(BusinessCareer.new(params)) }
  describe '#show_period' do
    subject { business_career.show_period }

    context 'end_dateに値が設定されている' do
      let(:params) { { start_date: Date.new(2011, 11, 1), end_date: Date.new(2011, 12, 1) } }
      it { is_expected.to eq '2011/11〜2011/12' }
    end

    context 'end_dateがnil' do
      let(:params) { { start_date: Date.new(2011, 11, 1), end_date: nil } }
      it { is_expected.to eq '2011/11〜継続中' }
    end
  end

  describe '#form_works' do
    skip 'TODO: html入力フォーム作成処理のため一旦スキップ'
  end
end
