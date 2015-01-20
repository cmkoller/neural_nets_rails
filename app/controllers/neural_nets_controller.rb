class NeuralNetsController < ApplicationController
  def index
    @neural_nets = NeuralNet.all
  end

  def new
    @neural_net = NeuralNet.create
    redirect_to neural_net_nodes_path(@neural_net)
  end

  def update
    @neural_net = NeuralNet.find(params[:id])
    if @neural_net.update(neural_net_params)
      flash[:info] = "Neural net updated."
      @preset_input = @neural_net.selected_input
      @desired_output = @neural_net.selected_output
      render 'show'
    else
      flash[:warning] = @neural_net.errors.full_messages.join(".  ")
      render 'edit'
    end
  end

  def show
    @neural_net = NeuralNet.find(params[:id])
  end

  private

  def neural_net_params
    params.require(:neural_net).permit(:name, :input, :output, :times, :generate_bias)
  end

end
