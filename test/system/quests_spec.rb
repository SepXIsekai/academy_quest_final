require "rails_helper"

RSpec.describe "Quests Management", type: :system do
  before do
    driven_by :selenium, using: :headless_chrome
    @quest = Quest.create!(activity: "Existing Quest")
  end

  it "creates a new quest" do
    visit quests_path
    fill_in "quest_activity", with: "New Quest via Capybara"
    click_button "Create Quest"
    expect(page).to have_content("New Quest via Capybara")
  end
end
