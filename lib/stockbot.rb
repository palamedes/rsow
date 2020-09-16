class StockBot
  include AlphavantageAPI

  attr_reader :symbol, :company, :quote, :response

  # Get a list of the symbols we need to be looking at every tick
  def self.getSymbols
    Company.all.map{|c| c.symbol}
  end

  def self.getBots
    Company.all.map{|c| StockBot.new c.symbol}
  end

  def self.go
    # This is going to be a looping system
    looping = true
    # We need to get our list of bots
    bots = self.getBots
    # We need to determine how long to sleep between each pull, up to 5 seconds
    timePer = 60 / bots.count
    # Determine how long of a pause we are putting into place
    pausePer = timePer - 3
    # Total pause left over
    totalPause = pausePer * bots.count

    while looping == true
      # Define our start and end times so we don't loop in data during off market times
      startTime = DateTime.now.midnight + 9.hours + 30.minutes
      endTime = DateTime.now.midnight + 16.hours + 30.minutes

      # Clear the IRB Terminal
      system('clear')
      # Are we after 9:30 and before 16:30
      if DateTime.now.between? startTime, endTime
        # For each bot do this loop
        bots.each do |bot|
          # Sleep between each pull so we don't anger the internet gods
          sleep pausePer
          # Add some rescues that don't actually do anything
          bot.getQuote rescue "NO GET QUOTE"
          bot.saveQuote rescue "NO SAVE QUOTE"
        end
        # Sleep for just over a minute and go again.
        puts "Sleeping #{totalPause}\n\n\n"
        sleep totalPause
      else
        # Tell the world we are sleeping until start time.
        timeUntilStart = startTime.to_i - DateTime.now.to_i
        puts "Sleeping until between market hours :: #{Time.at(timeUntilStart).utc.strftime("%H:%M:%S")}"
        sleep 1
      end

    end
  end

  # Get a company based on the symbol from the DB, OR pull it from API and save it to db
  def self.getCompany symbol
    # @TODO REplace this with IEX instead of alphavantage
    stock = AlphavantageAPI::Stock.new symbol
    # Load our company or create a new one
    company = Company.where(symbol: symbol).first_or_create
    # Stuff the information into the company
    company.from_json stock.response.body
    # Save that bad boy.
    company.save
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
#    @client = IEX::Api::Client.new
  end

  # Get our company data from the db and save it local to the bot
  def getCompany
    @company = Company.where(symbol: @symbol).first_or_create
    raise if @company.new_record?
  end

  # Get a quote for a symbol and stuff it into the db
  def getQuote
    # Make Yahoo Faraday Request
    req = Faraday.get("https://search.yahoo.com/search?p=#{@symbol} stock quote") rescue nil
    if req.nil? || req.body.nil?
      puts "Faraday Request threwup"
      puts req.inspect
    else
      quote = req.body.match(/"fin_quotePrice.*?>(.*?)</)
      if quote[1].nil? || quote[1].empty?
        puts "Quote returned nil/empty:"
        puts quote.inspect
        puts req.inspect
      else
        @quote = quote[1].to_f
        # Save our previous quote
        @prevQuote = @quote

        puts "#{@symbol}: #{@quote}"

        return @quote
      end
    end
    return nil
  end

  # Save that sucker
  def saveQuote
    return if @quote.nil?
    Rawquote.create company: company,
                     price: @quote,
                     volume: 0,
                     datetime: DateTime.now
  end

end
