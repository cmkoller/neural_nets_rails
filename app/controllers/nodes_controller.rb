class NodesController <ApplicationController
  def create
    @neural_net = NeuralNet.find(params[:neural_net_id])
    @node = @neural_net.create_node(node_params[:layer].to_i)

    redirect_to edit_neural_net_path(@neural_net)
  end

  def destroy
    @node = Node.destroy(params[:id])
    @neural_net = NeuralNet.find(params[:neural_net_id])
    redirect_to edit_neural_net_path(@neural_net)
  end

  private
  def node_params
    params.require(:node).permit(:layer)
  end
end
