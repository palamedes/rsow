class DesktopController < ApplicationController

  # [GET] /
  # Load the desktop
  def index
  end

  # [GET] /:page[.json]
  # @TODO This will need to either work as a full page load, or a json pull of just the document
  def page

    # Okay attempt to parse the page md file based on the params
    @document = MarkdownParser::Parser.parse "page/#{params[:page]}"
    # If it's a document then cool, if not route back to /
    if @document.nil? || @document[:published] == false
      redirect_to "/"
    else

      respond_to do |format|
        format.json {
          html = render_to_string action: :page, locals: { page: params[:page] }, layout: false, formats: [:html]
          render json: {
              document: @document,
              html: html
          }
        }
        format.html {}
      end
    end
  end

  # [GET] /blog/:post[.json]
  # @TODO this will need to also work using a .json request
  def post
    # Okay attempt to parse the page md file based on the params
    document = MarkdownParser::Parser.parse "post/#{params[:post]}"
    # If it's a document then cool, if not route back to /
    if document.nil? || document[:published] == false
      redirect_to "/"
    else
      respond_to do |format|
        format.json { render json: {} }
        format.html {
          @document = document
        }
      end
    end
  end

end
