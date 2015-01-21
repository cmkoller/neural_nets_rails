class PresetInputsController < ApplicationController
  def index
    @neural_net = NeuralNet.find(params[:neural_net_id])
    @preset_input = PresetInput.new
  end

  def create
    @neural_net = NeuralNet.find(params[:neural_net_id])
    @preset_input = PresetInput.new(preset_input_params)
    @preset_input.neural_net = @neural_net
    @preset_input.desired_output.neural_net = @neural_net
    if @preset_input.save
      flash[:info] = "Saved preset input."
      redirect_to neural_net_preset_inputs_path(@neural_net)
    else
      render :index
    end
  end

  def destroy
    @neural_net = NeuralNet.find(params[:neural_net_id])
    @preset_input = PresetInput.find(params[:id])
    @preset_input.desired_output.destroy
    @preset_input.destroy
    flash[:info] = "Preset Input/Output Pairing Deleted"
    redirect_to neural_net_preset_inputs_path(@neural_net)
  end

  private

  def preset_input_params
    params.require(:preset_input).permit!
  end

end
