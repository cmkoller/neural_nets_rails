require "rails_helper"

feature "View All Nets", %q(
As a user
I want to view all the neural nets
So that I can see what I and other people have made

Acceptance Criteria
[ ] I must be able to see all neural nets

) do

  scenario 'user visits home page' do
    nn1 = FactoryGirl.create(:neural_net)
    nn2 = FactoryGirl.create(:neural_net)
    visit neural_nets_path
    expect(page).to have_content(nn1.name)
  end

end
