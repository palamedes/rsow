class VellumSpaceController < ApplicationController
  layout 'vellum_space'

  # [GET] /
  def index
    redirect_to '/vellum.space/demo/menu-demo'
  end

  # [GET] /demo/:demo
  def demo
    @demo = params[:demo]
  end

end