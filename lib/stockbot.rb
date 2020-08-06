class StockBot
  include AlphavantageAPI

  attr_reader :symbol, :company, :quote, :response

  # Get a list of the symbols we need to be looking at every tick
  def self.getSymbols
    Company.all.map{|c| c.symbol}
  end

  # @TODO Each stock will have it's own bot... So this will be an object with ONE company
  #  - Each time a bot looks at the price it iwll have indicators and think about what to do
  #  - We need to know the original stock price but also the buy in price, adn thenthe current price..etc..

  def initialize symbol
    # Set our holding spaces to nil
    @quote, @prevQuote = nil
    # Set our symbol
    @symbol = symbol.to_s.upcase
    # Get our company
    getCompany
    # @TODO Test to make sure we are ready to go, else set some error code and don't proceed or let calls happen
    @client = IEX::Api::Client.new
  end

  # Get a company based on the symbol from the DB, OR pull it from API and save it to db
  def getCompany
    # @TODO REplace this with IEX instead of alphavantage
    stock = AlphavantageAPI::Stock.new @symbol
    # Load our company or create a new one
    @company = Company.where(symbol: @symbol).first_or_create
    # Stuff the information into the company
    @company.from_json stock.response.body
    # Save that bad boy.
    @company.save
  end

  # Get a quote for a symbol and stuff it into the db
  def getQuote
    # Get our quote
    @quote = @client.quote @symbol
    # Save our previous quote
    @prevQuote = @quote
  end

  # Save that sucker
  def saveQuote
    Valuation.create company: company,
                     price: @quote.latest_price,
                     volume: @quote.iex_volume,
                     datetime: DateTime.now
  end

  # Do the loop thing for this stock.
  def go
    looping = true
    while looping == true
      # Get the quote
      getQuote
      # save the quote
      saveQuote
      # Do some logic around the investment shit... eventually
      # Sleep for just over a minute and go again.
      sleep 10
    end
  end





end
