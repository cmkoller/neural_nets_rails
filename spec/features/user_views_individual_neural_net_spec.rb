require "rails_helper"

feature "View Individual Net", %q(
As a user
I want to view an individual net
So that I can see how it's laid out

Acceptance Criteria
[ ] I must be able to click on a net's name from the neural nets index page
[ ] I must be able to see the graph showing the net

) do

  scenario 'user views empty net by clicking name' do
    nn = FactoryGirl.create(:neural_net)
    visit neural_nets_path
    click_on nn.name
    expect(page).to have_content(nn.name)
  end

  scenario 'user views net with nodes' do
    nn = FactoryGirl.create(:neural_net)
    nn.create_node(0)
    nn.create_node(0)
    nn.create_node(1)
    nn.create_node(2)
    visit neural_nets_path
    click_on nn.name
    expect(page).to have_content(nn.name)
    expect(page).to have_css("#graph-container")
  end

end
