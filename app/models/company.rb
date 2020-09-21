class Company < ApplicationRecord

  # Relationships
  has_many :quotes, -> { order(datetime: :asc) }
  has_many :rawquotes, -> { order(datetime: :asc) }

  # Validations
  validates :symbol, :assettype, :name, :description, :exchange, :currency, :country, presence: true

  # Quickly get a company by symbol
  def self.symbol symbol
    self.where(symbol: symbol.to_s.upcase).first_or_create
  end

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

  # Get company information

  # Get a quote

  # Normalize data
  # Goes back in time and takes raw quotes and normalizes the data into something we can better use
  # arguments:
  #  range = number of days back in time we are going to go to normalize data. Default: 3

  def normalize range = 3
    return unless range.integer?
    # Go back in time [range] number of days and do this thing
    range.downto(0).each do |i|
      # Get our day
      day = DateTime.now.midnight - i.days
      # Get the quotes for the day in question
      daysQuotes = rawquotes.where(datetime: day.midnight..day.end_of_day).order(:datetime)

      # Do we even have this day?
      unless daysQuotes.empty?
        quote = quotes.where(datetime: day.midnight, scale: 'DAY').first_or_create
        quote.high, quote.low, quote.open, quote.close = periodCandle daysQuotes
        quote.save

        # Get HOUR range of data
        (9..16).each do |h|
          hour = DateTime.now.midnight - i.days + h.hours
          hourQuotes = rawquotes.where(datetime: hour..hour+1.hour).order(:datetime)

          unless hourQuotes.empty?
            quote = quotes.where(datetime: hour, scale: 'HOUR').first_or_create
            quote.high, quote.low, quote.open, quote.close = periodCandle daysQuotes
            quote.save
          end


        end


        # Get 30min range of data
        # Get 5min range of data
      end

    end

  end


  # Return [high, low, open, close] for period
  def periodCandle quotes
    d = quotes.order(:datetime).map(&:price)
    [d.max, d.min, d.first, d.last]
  end

end
