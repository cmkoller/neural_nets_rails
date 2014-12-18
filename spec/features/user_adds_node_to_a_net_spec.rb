require "rails_helper"

feature "Add Node To Net", %q(
As a user
I want to add nodes to a net I have created
So that it isn't empty and I can successfully run it later

Acceptance Criteria
[ ] I must be have created a net and be on the "Design Your Net" page
[ ] Clicking the "+" next to a layer should add a node to that layer
[ ] I can add nodes to all existing layers
[ ] I can begin a new layer by adding a node to the area below the last existing layer
[ ] Each added node should display on the page as an empty div with class "node", in line with its layer
) do

  before(:each) do
    visit root_path
    click_on "Create New Net"
  end

  scenario 'user successfully adds first node' do
    page.find('#add_layer_0').click
    expect(page).to have_selector('div.layer_0_nodes div.node')
    expect(page).to have_selector('#add_layer_1')
  end

  scenario 'user successfully multiple nodes, on multiple layers' do
    page.find('#add_layer_0').click
    page.find('#add_layer_0').click
    page.find('#add_layer_1').click
    page.find('#add_layer_2').click
    expect(page).to have_selector('div.layer_0_nodes div.node')
    expect(page).to have_selector('div.layer_1_nodes div.node')
    expect(page).to have_selector('div.layer_2_nodes div.node')
    expect(page).to have_selector('#add_layer_3')
  end

end
