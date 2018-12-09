class SkillVersion < ApplicationRecord
  belongs_to :skill

  validates :version, presence: true, uniqueness: true
end
