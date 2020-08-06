class StocksController < ApplicationController

  # [GET] /stocks[.json]
  # Load the desktop with the stocks window and the stocks in the system we are currently watching + positions
  def index
    # Get a list of our companies for the view.
    @companies = Company.all

    respond_to do |format|
      format.json {
        html = render_to_string action: :index, layout: false, formats: [:html]
        render json: {
            document: {slug: 'stocks'},
            html: html
        }
      }
      format.html {}
    end
  end

  # [GET] /stocks/:id[.json]
  # Get the information for a given stock
  def show

  end


  # [GET] /stocks/{:id|:symbol}/valuation.json
  # Get just the valuation for a given company ID or company symbol
  def valuation
    company = Company.symbol params[:symbol]

    redirect_to :back if company.new_record?

    respond_to do |format|
      format.json {
        render json:
          company.valuations.today.map { |v| v.as_csv }
      }
    end
  end

end