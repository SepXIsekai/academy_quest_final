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

  it "toggles quest status" do
    visit quests_path
    quest_checkbox = find("#quest_status_#{@quest.id}")
    original_checked = quest_checkbox.checked?

    quest_checkbox.click

    if original_checked
      expect(page).to have_unchecked_field("quest_status_#{@quest.id}")
    else
      expect(page).to have_checked_field("quest_status_#{@quest.id}")
    end
  end

  it "destroys a quest" do
    visit quests_path

    find("#destroy_quest_#{@quest.id}").click

    expect(page).not_to have_content(@quest.activity)
  end

  it "navigates to My Brags page from the button under profile" do
    visit quests_path

    # ตรวจสอบว่าปุ่มมีอยู่
    expect(page).to have_link("My Brags Document", href: brags_path)

    # กดปุ่ม
    click_link "My Brags"

    # ตรวจสอบว่าอยู่บนหน้า brags index
    expect(page).to have_current_path(brags_path)
    expect(page).to have_content("My Brags") # สมมติว่ามี title แบบนี้
  end
end
