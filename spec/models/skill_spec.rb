require 'rails_helper'

RSpec.describe Skill, type: :model do
  describe '入力チェック' do
    let(:skill) { build(:skill) }

    context '名前' do
      check_for_required(FactoryBot.build(:skill), :name, 'ruby')
    end
  end
end
