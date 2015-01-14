#FFBall

##User Stories
  As an authenticated user
  I want to create a league
  So that I can invite my friends to it
###Acceptance Criteria
* If I'm signed in, I have an option to create a league
* If I'm not signed in, I cannot create a league
* I am required to specify the amount of members
* I am required to specify the league name
* I am able to provide a league password
* I am able to provide email addresses to invite users
* I am able to change the league name after creation
* I am able to delete the league after creation,
  only if the league has less than the specified amount of members

  As an authenticated user
  I want to create a team
  So that I can put all my favorite players on it
###Acceptance Criteria
* If I'm signed in and have been invited to a league, I have an option to create a team
* If I'm not signed in, I cannot create a team
* I am able to add players to the team
* I am able to change the team name after creation
* I am able to delete the team after creation,
  only if its league has less than the specified amount of members
