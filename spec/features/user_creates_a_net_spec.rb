require "rails_helper"

feature "Create a Net", %q(
As a user
I want to create a neural net
So that I can modify and train it

Acceptance Criteria
[ ] I must click the "Build" button
[ ] Clicking the button creates a new net in the database
[ ] Clicking the button brings me to a new page where I can edit my net

) do

  before(:each) do
    visit neural_nets_path
  end

  scenario 'user visits home page and clicks "Build"' do
    original_num_nets = NeuralNet.all.length
    click_on "Build"
    expect(NeuralNet.all.length).to eq(original_num_nets + 1)
    expect(page).to have_content("Design your net")
  end

end
