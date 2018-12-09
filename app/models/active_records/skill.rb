class Skill < ApplicationRecord
  has_many :versions, class_name: 'SkillVersion'

  validates :name, presence: true, uniqueness: true
end
