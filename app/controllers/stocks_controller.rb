class StocksController < ApplicationController

  # [GET] /stocks[.json]
  # Load the desktop with the stocks window and the stocks in the system we are currently watching + positions
  def index
    respond_to do |format|
      format.json { render json: {} }
      format.html {

      }
    end
  end

  # [GET] /stocks/:id[.json]
  # Get the information for a given stock
  def show

  end


end