class Valuation < ApplicationRecord

  # Relationships
  belongs_to :company

  # validations
  validates :datetime, :open, :high, :low, :close, :volume, presence: true

  # Get me todays valuations
  def self.today
    where 'datetime between ? and ?', DateTime.now.midnight+9.hours, DateTime.now.midnight+16.hours
  end

  # Dump to json just what we need
  def as_json(*)
    super.except('id', 'company_id', 'datetime', 'created_at', 'updated_at').tap do |hash|
      hash['date'] = datetime
    end
  end

  # Dump data we need as a csv
  def as_csv
    [ datetime.to_s, low, open, close, high ]
  end

end
