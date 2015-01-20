class StaticsController < ApplicationController
  def index
    render :index, layout: "custom_layout"
  end

  def learn
    render :learn
  end
end
