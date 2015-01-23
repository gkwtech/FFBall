require "rails_helper"

feature "user creates team" do
  scenario "and receives confirmation when correctly filling out forms" do
    # user = FactoryGirl.create(:user)
    # team = FactoryGirl.create(:team)
    # league = FactoryGirl.create(:league)

    # visit new_user_session_path

    # fill_in "Email", with: user.email
    # fill_in "Password", with: user.password

    # click_button "Log in"

    # visit league_path(league)
    # click_button "Add Team"
    # fill_in "Name", with: team.name
    # click_button "Create Team"

    # expect(page).to have_content("Team created")
  end

  scenario "and receives errors when incorrectly filling out forms" do
    # user = FactoryGirl.create(:user)
    # team = FactoryGirl.create(:team)
    # league = FactoryGirl.create(:league)

    # visit new_user_session_path

    # fill_in "Email", with: user.email
    # fill_in "Password", with: user.password

    # click_button "Log in"

    # visit league_path(league)
    # click_button "Add Team"
    # click_button "Create Team"

    # expect(page).to have_content("Name can't be blank")
  end

  scenario "and is given an error if not signed in" do
    # team = FactoryGirl.create(:team)
    # league = FactoryGirl.create(:league)
    # visit new_league_team_path(league, team)

    # expect(page).to have_content("Must be signed in to do that.")
  end
end
