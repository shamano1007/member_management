class Profile < ApplicationRecord
  validates :birthdate, presence: true
end
