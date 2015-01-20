require "rails_helper"

feature "Delete Node From Net", %q(
As a user
I want to delete nodes to a net I have created
So that I can fix my mistakes if I added too many nodes

Acceptance Criteria
[ ] I must be have created a net and be on the "Design Your Net" page
[ ] Clicking the "x" next to a layer should delete a node from that layer
[ ] If I click "x" on an empty layer (bottom layer), nothing happens
) do

    before(:each) do
      visit neural_nets_path
      click_on "Build"
      page.find('#add_layer_0').click
    end

    scenario 'user deletes an existing node' do
      page.find('#delete_layer_0').click
      expect(page).to have_no_selector('div.layer_0_nodes div.node')
      expect(page).to have_no_selector('#add_layer_1')
    end

    scenario 'user tries to delete node from empty layer' do
      page.find('#delete_layer_1').click
      expect(page).to have_selector('div.layer_0_nodes div.node')
      expect(page).to have_selector('#add_layer_1')
    end

  end
