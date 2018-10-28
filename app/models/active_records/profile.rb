class Profile < ApplicationRecord
  belongs_to :user

  validates :birthdate, date: true
end
