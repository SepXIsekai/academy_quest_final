require "rails_helper"

RSpec.describe "MyBrags Docs", type: :system do
  it "navigates to My Brags page from the button under profile" do
    visit brags_path


    expect(page).to have_link("Back to Quests")


    click_link "Back to Quests"


    expect(page).to have_current_path(quests_path)
    expect(page).to have_content("Academy Quests")
  end
end
