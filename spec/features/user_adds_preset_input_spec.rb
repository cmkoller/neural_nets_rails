require "rails_helper"

feature "Create Preset Inputs", %q(
As a user
I want to create preset input/output pairings
So that I can easily train my net

Acceptance Criteria
[ ] I must visit the 'neural_net_preset_inputs' path
[ ] I should be able to see the net's nodes
[ ] I can create a new preset input by selecting nodes to be active
[ ] I can create a desired output for the preset input by selecting output nodes to be active
[ ] I must assign a name to my input, so it is easily identifyable
[ ] I must assign a name to my output
[ ] The numbers of input and output nodes displayed must match the number of in/out nodes in my net
[ ] Once I add an input/output pairing I should see it at the side of the screen
[ ] When I'm finished creating pairings, I can move on to view and train the net.

  ) do

  # scenario 'user successfully adds first node' do
  #   page.find('#add_layer_0').click
  #   expect(page).to have_selector('div.layer_0_nodes div.node')
  #   expect(page).to have_selector('#add_layer_1')
  # end
  #

end
