class BusinessCareer < ApplicationRecord
  include StringTrueDecision

  belongs_to :user

  serialize :work

  validates :start_date, month: true
  validates :end_date, month: { blank: true }
  validate :from_to_validate
  validates :industries, presence: true
  validates :overview, presence: true

  class << self
    def work_columns
      Settings.business_work.map do |column|
        {
          name: "work/#{column}",
          column: column
        }
      end
    end
  end

  def initialize(params)
    work_params = work_columns_setting(params)
    super
    input_work(work_params)
  end

  def assign_attributes(params)
    work_params = work_columns_setting(params)
    super
    input_work(work_params)
  end

  private

  def work_columns_setting(params)
    BusinessCareer.work_columns.each_with_object({}) do |info, o|
      o[info[:column]] = str_true?(params.delete(info[:name]))
    end
  end

  def input_work(work_params)
    self.work = work_params
  end

  def from_to_validate
    return if errors[:start_date].present? || errors[:end_date].present? || end_date.blank?
    return if start_date <= end_date

    errors.add(
      :end_date,
      :greater_than_or_equal_to,
      count: self.class.human_attribute_name(:start_date)
    )
  end
end
