require "rails_helper"

feature "commissioner runs a draft" do
  scenario "but receives errors if not signed in" do
    commissioner = FactoryGirl.create(:user)
    league = League.create(
      name: "name",
      member_amount: "8",
      commissioner_id: commissioner.id)

    visit new_league_draft_path(league)
    expect(page).to have_content("Must be signed in to do that")
  end

  scenario "but receives errors if role is not set to commissioner" do
    commissioner = FactoryGirl.create(:user)
    league = League.create(
      name: "name",
      member_amount: "8",
      commissioner_id: commissioner.id)
    user = FactoryGirl.create(:user)
    team = Team.create(
      name: "teamname",
      league_id: league.id,
      user_id: user.id)
    draft = Draft.create(league_id: league.id)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    click_link league.name
    click_link "Start Draft"
    expect(page).to have_content("Only the commissioner can do that")
  end

  scenario "and must have the required number of members" do
    commissioner = FactoryGirl.create(:user)
    league = League.create(
      name: "name",
      member_amount: "8",
      commissioner_id: commissioner.id)
    team = Team.create(
      name: "teamname",
      user_id: commissioner.id,
      league_id: league.id)
    visit new_user_session_path
    fill_in "Email", with: commissioner.email
    fill_in "Password", with: commissioner.password
    click_button "Log in"

    click_link league.name
    expect(page).to have_content("Your league is not full yet and cannot draft")
  end

  scenario "and is able to set the draft order" do
    # user = FactoryGirl.create(:user)
    # league = FactoryGirl.create(:league)
    # draft = FactoryGirl.create(:draft)
    # league.commissioner_id = user.id

    # visit new_user_session_path
    # fill_in "Email", with: user.email
    # fill_in "Password", with: user.password
    # click_button "Log in"

    # visit new_league_draft_path(league, draft)
  end

  scenario "and is able to view a list of players on the draft page" do
    commissioner = FactoryGirl.create(:user)
    league = League.create(
      name: "name",
      member_amount: "8",
      commissioner_id: commissioner.id)
    team = Team.create(
      name: "teamname",
      user_id: commissioner.id,
      league_id: league.id)
    player = FactoryGirl.create(:player)
    users = {}
    teams = {}
    names = %w(a b c d e f g)
    names.each do |name|
      users[name] = FactoryGirl.create(:user)
      teams[name] = Team.create(name: name, league_id: league.id, user_id: users[name].id)
    end

    visit new_user_session_path
    fill_in "Email", with: commissioner.email
    fill_in "Password", with: commissioner.password
    click_button "Log in"

    click_link league.name
    click_link("Start Draft", :match => :first)
    click_button("Submit")
    expect(page).to have_content(player.first_name)
  end

  scenario "and is able to assign players, pick-by-pick" do
    ###NOMINATION DONE VIA JQUERY###
    # commissioner = FactoryGirl.create(:user)
    # league = League.create(
    #   name: "name",
    #   member_amount: "8",
    #   commissioner_id: commissioner.id)
    # team = Team.create(
    #   name: "teamname",
    #   user_id: commissioner.id,
    #   league_id: league.id)
    # player = FactoryGirl.create(:player)
    # users = {}
    # teams = {}
    # names = %w(a b c d e f g)
    # names.each do |name|
    #   users[name] = FactoryGirl.create(:user)
    #   teams[name] = Team.create(name: name, league_id: league.id, user_id: users[name].id)
    # end

    # visit new_user_session_path
    # fill_in "Email", with: commissioner.email
    # fill_in "Password", with: commissioner.password
    # click_button "Log in"

    # click_link league.name
    # click_link("Start Draft", :match => :first)
    # click_button("Submit")
    # save_and_open_page
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
