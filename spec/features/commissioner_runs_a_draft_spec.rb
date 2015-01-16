require "rails_helper"

feature "commissioner runs a draft" do
  scenario "but receives errors if not signed in" do
    # user = FactoryGirl.create(:user)
    # league = FactoryGirl.create(:league)
    # draft = FactoryGirl.create(:draft)
    # visit new_user_session_path
    # fill_in "Email", with: user.email
    # fill_in "Password", with: user.password
    # click_button "Log in"
    # visit new_league_draft_path(league, draft)
  end
  scenario "but receives errors if role is not set to commissioner" do
  end
  scenario "and is able to set the draft order" do
  end
  scenario "and is able to view a list of players on the draft page" do
  end
  scenario "and is able to assign players, pick-by-pick" do
  end
  scenario "but is unable to assign already-assigned players" do
  end
  scenario "and is able to view draft history as it occurs" do
  end
  scenario "and is able to undo changes" do
  end
  scenario "and is taken to a confirmation page before finishing" do
  end
  scenario "and the draft results are reflected in the league" do
  end
end
