class NodesController <ApplicationController
  def create
    @neural_net = NeuralNet.find(params[:neural_net_id])
    @neural_net.create_node(params[:layer].to_i)
    redirect_to edit_neural_net_path(@neural_net)
  end

  private
  def node_params
    params.require(:node).permit(:layer)
  end
end
