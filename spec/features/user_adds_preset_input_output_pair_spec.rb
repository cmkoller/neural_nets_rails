require "rails_helper"

feature "Create Preset Inputs", %q(
As a user
I want to create preset input/output pairings
So that I can easily train my net

Acceptance Criteria
[ ] I must visit the 'neural_net_preset_inputs' path
[ ] I can create a new preset input by selecting nodes to be active
[ ] I can assign a name to my input, so it is easily identifyable
[ ] I can create a desired output for the preset input by selecting output nodes to be active
[ ] I can assign a name to my output
[ ] The numbers of input and output nodes displayed must match the number of in/out nodes in my net
[ ] Once I add an input/output pairing I should see it at the side of the screen
[ ] When I'm finished creating pairings, I can move on to view and train the net.

  ) do

  let(:neural_net) { FactoryGirl.create(:neural_net) }
  before(:each) do
    visit edit_neural_net_path(neural_net)
    page.find('#add_layer_0').click
    page.find('#add_layer_0').click
    page.find('#add_layer_1').click
    click_on "Save Net"
    visit neural_net_preset_inputs_path(neural_net)
  end

  scenario 'user successfully creates input/output pairing' do
    fill_in "Input Name:", with: "False/False"
    fill_in "Output Name:", with: "False"
    click_button "Create"
    expect(page).to have_content("Saved")
    expect(page).to have_content("False/False")
  end


end
