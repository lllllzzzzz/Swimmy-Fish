/*
  Swimmy Fish
  ===========

  A fish appears randomly from the left of the screen, and moves to the right.
  If the player makes it to the other side, the player gains 3 points.
  If the player hits a red block, player loses 3 points.
  If the player hits a green block, the block disappears and the player gains 1 point.
*/

void setup () {
  // Set up the window
  size(fishWidth * BLOCKS_TO_MOVE, fishHeight * LANES);
  frameRate(60);
  smooth();
  noStroke();
  // Clear the background so that the previous drawing is erased
  background(bgRGB);
  newGame();
}

void draw () {
  // Draw when the game is running
  // When the game is paused, do not draw to the screen
  if (!gameStart) {
    displayMenu();
  }
    
  else if (gamePaused) {
    pauseGame(width / 2, height / 2, pausedSize, pausedColour);
  }
    
  else {
    //Reset canvas, redraw background
    background(bgRGB);
    
    //Draw fish
    drawFish();
    //Draw barriers
    drawBarriers();
    //Display status bar showing score, high score, time remaining
    displayStatus(0, 210, 0, 0, width, 20);

    //Only move fish when the game is running
    fishX += FISH_SPEED;
    
    if (timer % 60 == 0) {
      timeLimit--;
    }
      
    else if (timeLimit == 0) {
      gameOver();
    }
      
    if (difficultyLevel == 6 && timer % 120 == 0) {
      resetBarriers();
    }

    timer++;

    //Detect collision
    for (int barrier = 0; barrier < N_BARRIERS; ++barrier) {
      if (hasFishHit(barrier)) {

        if (isFood[barrier]) {
          if (!hasBeenEaten[barrier]) {
            eatFood(barrier);
          }
        }

        else
        {
          //Reset game, reset player score
          killFish();
        }
      }
    }

  //Check if fish has left the screen
  if (hasFishWon()) {
    //Load next level of game
    loadNextLevel();
  }
  }
}
