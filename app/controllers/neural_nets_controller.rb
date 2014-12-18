class NeuralNetsController < ApplicationController
  def index
    @nets = NeuralNet.all
  end

  def new
    @net = NeuralNet.create
  end
end
