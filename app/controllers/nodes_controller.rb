class NodesController <ApplicationController
  def create
    @neural_net = NeuralNet.find(params[:neural_net_id])
    @node = @neural_net.nodes.build(node_params)

    if @node.save
      flash[:notice] = "Saved node."
    else
      flash[:alert] = "Failed to save node: #{@node.errors.full_messages.join(', ')}."
    end

    # @neural_net.create_node(params[:layer].to_i)
    redirect_to edit_neural_net_path(@neural_net)
  end

  private
  def node_params
    params.require(:node).permit(:layer)
  end
end
