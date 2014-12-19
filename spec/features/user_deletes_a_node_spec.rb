require "rails_helper"

feature "Add Node To Net", %q(
As a user
I want to add nodes to a net I have created
So that it isn't empty and I can successfully run it later

Acceptance Criteria
[ ] I must be have created a net and be on the "Design Your Net" page
[ ] Clicking the "x" next to a layer should delete a node from that layer
[ ] If I click "x" on an empty layer (bottom layer), nothing happens
) do

    before(:each) do
      visit root_path
      click_on "Create New Net"
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
