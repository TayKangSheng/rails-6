class HomeController < ApplicationController
  def index
    render :index, locals: {}
  end
end
