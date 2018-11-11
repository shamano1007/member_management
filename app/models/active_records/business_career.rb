class BusinessCareer < ApplicationRecord
  belongs_to :user

  validates :start_date, month: true
  validates :end_date, month: { blank: true }
  validates :industries, presence: true
  validates :overview, presence: true
end
