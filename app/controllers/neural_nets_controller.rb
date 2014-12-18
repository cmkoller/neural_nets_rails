class NeuralNetsController < ApplicationController
  def index
    @neural_nets = NeuralNet.all
  end

  def new
    @neural_net = NeuralNet.create
    redirect_to edit_neural_net_path(@neural_net)
  end

  def edit
    @neural_net = NeuralNet.find(params[:id])
  end

  def update
    @neural_net = NeuralNet.find(params[:id])

    if @neural_net.update(neural_net_params)
      flash[:info] = "Name updated."
    else
      flash[:warning] = @neural_net.errors.full_messages.join(".  ")
    end
    redirect_to edit_neural_net_path(@neural_net)
  end

  private

  def neural_net_params
    params.require(:neural_net).permit(:name)
  end

end
