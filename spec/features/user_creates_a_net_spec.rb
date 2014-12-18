require "rails_helper"

feature "Create a Net", %q(
As a user
I want to create a neural net
So that I can modify and train it

Acceptance Criteria
[ ] I must be on the home page and click the "Create New Net" button
[ ] Clicking the button creates a new net in the database
[ ] Clicking the button brings me to a new page where I can edit my net

) do

  before(:each) do
    visit root_path
  end

  scenario 'user visits home page and clicks "create new net"' do
    original_num_nets = NeuralNet.all.length
    click_on "Create New Net"
    expect(NeuralNet.all.length).to eq(original_num_nets + 1)
    expect(page).to have_content("Design your net")
  end

end
