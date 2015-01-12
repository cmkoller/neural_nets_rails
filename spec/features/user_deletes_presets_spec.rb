require "rails_helper"

feature "Delete Preset Input/Output Pairing", %q(
As a user
I want to delete a preset input/output pairing
So that I can get rid of extra presets that I accidentally made

) do

  let(:neural_net) { FactoryGirl.create(:neural_net) }
  before(:each) do
    visit neural_net_nodes_path(neural_net)
    page.find('#add_layer_0').click
    page.find('#add_layer_0').click
    page.find('#add_layer_1').click
    click_on "Save Net"
    visit neural_net_preset_inputs_path(neural_net)
    fill_in "Input Name:", with: "False/False"
    fill_in "Output Name:", with: "False"
    click_button "Create"
    expect(page).to have_content("Saved")
    expect(page).to have_content("False/False")
  end

  scenario 'user successfully creates input/output pairing' do
    
  end


end
