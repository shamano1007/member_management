class BusinessCareer < ApplicationRecord
  include StringTrueDecision

  belongs_to :user

  serialize :work

  validates :start_date, month: true
  validates :end_date, month: { blank: true }
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
    work_params = BusinessCareer.work_columns.each_with_object({}) do |info, o|
      o[info[:column]] = str_true?(params.delete(info[:name]))
    end
    super
    input_work(work_params)
  end

  private

  def input_work(work_params)
    self.work = work_params
  end
end
