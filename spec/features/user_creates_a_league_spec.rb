require "rails_helper"

feature "user creates league" do
  # Acceptance Criteria
  # * If I'm signed in, i have an option to sign out
  # * When I opt to sign out, I get a confirmation that my identity has been
  #   forgotten on the machine I'm using

  scenario "and receives confirmation when correctly filling out forms" do
    user = FactoryGirl.create(:user)
    league = FactoryGirl.create(:league)

    visit new_user_session_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_button "Log in"

    visit new_league_path
    fill_in "name", with: league.name
    fill_in "password", with: league.password
    click_button "Create League"

    expect(page).to have_content("League created")
  end

  scenario "and receives errors when incorrectly filling out forms" do
    user = FactoryGirl.create(:user)
    league = FactoryGirl.create(:league)

    visit new_user_session_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_button "Log in"

    visit new_league_path
    click_button "Create League"

    expect(page).to have_content("League name can't be blank")
  end
end
