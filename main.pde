/*
  Swimmy Fish
  ===========

  A fish appears randomly from the left of the screen, and moves to the right.
  If the player makes it to the other side, the player gains 3 points.
  If the player hits a red block, player loses 3 points.
  If the player hits a green block, the block disappears and the player gains 1 point.
*/

void setup () {
  size(fishWidth * BLOCKS_TO_MOVE, fishHeight * LANES);
  frameRate(60);
  smooth();
  noStroke();
  background(bgRGB);
  newGame();
}

void draw () {
  if (!gameStart) {
    displayMenu();
  }
    
  else if (gamePaused) {
    pauseGame(width / 2, height / 2, pausedSize, pausedColour);
  }
    
  else {
    background(bgRGB); // Redraw background
    drawFish();
    drawBarriers();
    displayStatus(0, 210, 0, 0, width, 20);

    fishX += FISH_SPEED; // Move fish horizontally
    timeLimit -= !(timer % 60); // Update time limit at interval
      
    if (!timeLimit) {
      gameOver();
    }
    
    if (difficultyLevel == 6 && !(timer++ % 120)) {
      resetBarriers();
    }

    // Detect collision
    for (int barrier = 0; barrier < N_BARRIERS; ++barrier) {
      if (hasFishHit(barrier)) {

        if (isFood[barrier]) {
          if (!hasBeenEaten[barrier]) {
            eatFood(barrier);
          }
        }

        else {
          killFish(); // Reset game and player score
        }
      }
    }

  // Check if fish has left the screen horizontally
  if (hasFishWon()) {
    loadNextLevel();
  }
  }
}
