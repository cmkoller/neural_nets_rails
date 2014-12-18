require "rails_helper"

feature "Change Net Name", %q(
As a user
I want to change my net's name once I've assigned it
Because I am indecisive and full of typos

Acceptance Criteria
[ ] I must be have created a net and be on the "Design Your Net" page
[ ] I must have already filled out the form at the top to assign a name
[ ] My name must be 255 characters or less. If too long, I should get an error message.
[ ] I must click "Change Name" and fill out the form
[ ] Clicking "Update Name" will keep me on the same page and display the name
[ ] Once a name has been set, the form should no longer appear.

) do

  before(:each) do
    visit root_path
    click_on "Create New Net"
    name = "My Neural Net"
    expect(page).to have_field("Name")
    fill_in "Name:", with: name
    click_on "Update Name"
  end


  scenario 'user successfully names net' do
    expect(page).to have_content(name)
    expect(page).to have_no_field("Name")
  end

end
