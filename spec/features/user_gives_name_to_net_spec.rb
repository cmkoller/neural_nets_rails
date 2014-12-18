require "rails_helper"

feature "Give Name To Net", %q(
As a user
I want to assign a name to my net
So that I can easily recognize it from the others

Acceptance Criteria
[ ] I must be have created a net and be on the "Design Your Net" page
[ ] I must fill out the form item at the top of the page labeled "name" and click "submit"
[ ] My name must be 255 characters or less
[ ] Clicking "Submit" will keep me on the same page and display the name
[ ] Once a name has been set, the form should no longer appear.

) do

  before(:each) do
    visit root_path
    click_on "Create New Net"
  end


  scenario 'user successfully names net' do
    name = "My Neural Net"
    expect(page).to have_field("Name")
    fill_in "Name:", with: name
    click_on "Update Name"
    expect(page).to have_content(name)
    expect(page).to have_no_field("Name")
  end

end
