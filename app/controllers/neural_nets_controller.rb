class NeuralNetsController < ApplicationController
  def index
    @neural_nets = NeuralNet.all
  end

  def new
    @neural_net = NeuralNet.new
  end

  def create
    @neural_net = NeuralNet.new(neural_net_params)

    if @neural_net.save
      redirect_to neural_net_preset_inputs_path(@neural_net)
    else
      @neural_nets = NeuralNet.all
      puts @neural_net.errors.full_messages.join(", ")
      render :new
    end
  end

  def update
    @neural_net = NeuralNet.find(params[:id])
    if @neural_net.update(neural_net_params) && !@neural_net.nodes.empty?
      @preset_input = @neural_net.selected_input
      @desired_output = @neural_net.selected_output
      render 'show'
    else
      flash[:warning] = @neural_net.errors.full_messages.join(".  ")
      flash[:warning] += @neural_net.nodes.empty? ? "You must add at least 1 node. " : ""
      redirect_to neural_net_nodes_path(@neural_net)
    end
  end

  def show
    @neural_net = NeuralNet.find(params[:id])
  end

  private

  def neural_net_params
    params.require(:neural_net).permit! #(:name, :input, :output, :times, :generate_bias)
  end

end
