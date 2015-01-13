class DataController < ApplicationController
  def index
    @neural_net = NeuralNet.find(params[:neural_net_id])

    respond_to do |format|
      format.json {
        render json: @neural_net.data
      }
    end
  end
end
