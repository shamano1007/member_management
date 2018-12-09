class Skill < ApplicationRecord
  has_many :versions, class_name: 'SkillVersion', dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
