class Company < ApplicationRecord

  # Relationships
  has_many :valuations, -> { order(datetime: :desc) }

  # Validations
  validates :symbol, :assettype, :name, :description, :exchange, :currency, :country, presence: true

  # When doing a .from_json {json} we have to do some special massaging of a couple fo the keys.
  def attributes=(hash)
    hash.each do |key, value|
      # Massage the key a tad
      key = key.downcase
      key = 'weekhigh52' if key == '52weekhigh'
      key = 'weeklow52' if key == '52weeklow'
      key = 'daymovingaverage50' if key == '50daymovingaverage'
      key = 'daymovingaverage200' if key == '200daymovingaverage'
      # Send all those key:value pairs to this object before saving it
      send("#{key}=", value)
    end
  end

  # Quickly get a company by symbol
  def self.symbol symbol
    self.where(symbol: symbol.to_s.upcase).first_or_create
  end

end
