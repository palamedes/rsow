# Alphavantage.co is the service I'm using to gather market data.
# Note: uses Faraday Gem 1.0.1.. Add to your Gem file: gem 'faraday', '~> 1.0'
#
# Documentation of their API:
# https://www.alphavantage.co/documentation/#latestprice
#
# Example of how to pull Company data using API.
# https://www.alphavantage.co/query?function=OVERVIEW&symbol=ccl&apikey={apikey}

module Alphavantage

  # Get the information for a given company and stuff it into the db.
  class CompanyAPI
    # CALL: AlphavantageAPI::Company 'IBM'
    def initialize symbol
      # @TODO MOVE THIS TO ENVIRONMENT OR SOMETHING (For now its not important because its not paid for but a free key)
      alphavantage_apikey = "8M1NABRQBD3I1PEQ"
      # Upcase that symbol just incase.
      symbol = symbol.upcase
      # Build our URL around what we are getting /// @TODO MOVE KEY OUT OF HERE
      url = "https://www.alphavantage.co/query?function=OVERVIEW&symbol=#{symbol}&apikey=#{alphavantage_apikey}"
      # Go get that data
      @response = Faraday.get url
      # Load our company or create a new one
      @company = Company.where(symbol: symbol).first_or_create
      # Stuff the information into the company
      @company.from_json @response.body
      # Save that bad boy.
      @company.save
    end
    # Just incase you need it.
    def response
      @response
    end
  end

  # Get the intraday information for a given company at a 1 minute time scale
  # NOTE:  Okay I'm starting to realize that this isn't useful.  It appears to be delayed by a full day..  bleh.
  class IntradayAPI
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
    # Give us the response object
    def response
      @response
    end
    # Get us the timeSeries
    def timeSeries
      @timeSeries
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


