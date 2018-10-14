require 'rails_helper'

RSpec.describe Skill, type: :model do
  describe '入力チェック' do
    let(:skill) { build(:skill) }

    context '名前' do
      check_for_required(FactoryBot.build(:skill), :name, 'ruby')
    end

    context '重複' do
      before { create(:skill, name: 'ruby') }
      validator_error(FactoryBot.build(:skill, name: 'ruby'), :name)
    end
  end
end
