class StaticsController < ApplicationController
  def index
    render :index, layout: "custom_layout"
  end
end
