# Alphavantage.co is the service I'm using to gather market data.
# Note: uses Faraday Gem 1.0.1.. Add to your Gem file: gem 'faraday', '~> 1.0'
#
# Documentation of their API:
# https://www.alphavantage.co/documentation/#latestprice
#
# Example of how to pull Company data using API.
# https://www.alphavantage.co/query?function=OVERVIEW&symbol=ccl&apikey={apikey}

module AlphavantageAPI

  # Get the information for a given company and stuff it into the db.
  class Stock
    attr_reader :response

    # CALL: obj = AlphavantageAPI::Company.new :IBM
    def initialize symbol
      # @TODO MOVE THIS TO ENVIRONMENT OR SOMETHING (For now its not important because its not paid for but a free key)
      alphavantage_apikey = "8M1NABRQBD3I1PEQ"
      # Upcase that symbol just incase.
      symbol = symbol.to_s.upcase
      # Build our URL around what we are getting /// @TODO MOVE KEY OUT OF HERE
      url = "https://www.alphavantage.co/query?function=OVERVIEW&symbol=#{symbol}&apikey=#{alphavantage_apikey}"
      # Go get that data
      @response = Faraday.get url
    end

  end

  # Get a single quote for a given stock
  class Quote
    attr_reader :response, :price, :open, :high, :low, :close, :volume, :change, :change_percent

    # CALL: obj = AlphavantageAPI::Quote.new :IBM
    def initialize sym
      # Upcase and to string so we can send string or symbol
      sym = sym.to_s.upcase
      # Store it
      @symbol = sym
      # @TODO MOVE THIS TO ENVIRONMENT OR SOMETHING (For now its not important because its not paid for but a free key)
      alphavantage_apikey = "8M1NABRQBD3I1PEQ"
      # define our URL
      url = "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=#{@symbol}&apikey=#{alphavantage_apikey}"
      # Get a response
      @response = Faraday.get url
      # Go through the response and pass out the data
      # @TODO Add error checking on the response.. because.. geez.. this could be ugly.. uglier I mean.. damn..
      @price = JSON.parse(@response.as_json['body'])['Global Quote']['05. price'].to_f
      @open = JSON.parse(@response.as_json['body'])['Global Quote']['02. open'].to_f
      @high = JSON.parse(@response.as_json['body'])['Global Quote']['03. high'].to_f
      @low = JSON.parse(@response.as_json['body'])['Global Quote']['04. low'].to_f
      @volume = JSON.parse(@response.as_json['body'])['Global Quote']['06. volume'].to_f
      @change = JSON.parse(@response.as_json['body'])['Global Quote']['09. change'].to_f
      @change_percent = JSON.parse(@response.as_json['body'])['Global Quote']['10. change percent'].to_f
      @close = JSON.parse(@response.as_json['body'])['Global Quote']['08. previous close'].to_f
    end

  end

# @TODO make a class that is just a singelton that will do the work of calling quotes over and over for each one of the
# companies that we have in the system.



  # Get the intraday information for a given company at a 1 minute time scale
  # NOTE:  Okay I'm starting to realize that this isn't useful.  It appears to be delayed by a full day..  bleh.
  class Intraday
    attr_reader :response, :timeSeries

    # AlphavantageAPI::Intraday.get 'IBM'
    def initialize symbol
      # Upcase the symbol
      symbol = symbol.upcase
      # Get our Company object based on the symbol
      @company = Company.where(symbol: symbol).first_or_create
      # Make sure our company is in the system
      if @company.new_record?
        # GO GET OUR COMPANY USING CompanyAPI above
      end
      # @TODO MOVE THIS TO ENVIRONMENT OR SOMETHING (For now its not important because its not paid for but a free key)
      alphavantage_apikey = "8M1NABRQBD3I1PEQ"
      # Upcase that symbol just incase.
      symbol = symbol.upcase
      # Build our URL around what we are getting /// @TODO MOVE KEY OUT OF HERE Also not sure if I should use full or not.. probably not.
      # url = "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=#{symbol}&interval=1min&outputsize=full&apikey=#{alphavantage_apikey}"
      url = "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=#{symbol}&interval=1min&outputsize=compact&apikey=#{alphavantage_apikey}"
      # Go get that data from the url above
      @response = Faraday.get url
      # Crunch it into an object
      @jsonResponse = JSON.parse @response.body
      # Now lets just get the time series
      @timeSeries = @jsonResponse['Time Series (1min)']
      # Now iterate through the time series arrays and dig out the datetime and values
    end
    # Save timeSeries information as valuations
    def parseResponse
      @timeSeries.each do |datetime, value|
        # Using our datetime
        @valuation = Valuation.where(company: @company, datetime: datetime.to_time).first_or_create
        @valuation.open = value['1. open']
        @valuation.high = value['2. high']
        @valuation.low = value['3. low']
        @valuation.close = value['4. close']
        @valuation.volume = value['5. volume']
        @valuation.save
      end
    end

  end

end


