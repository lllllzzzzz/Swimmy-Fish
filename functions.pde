/*
  Swimmy Fish - Functions
*/

/*
  drawFish()
  - Draw fish at coordinates fishX/fishY.
*/
void drawFish() {
  fill(fishRGB); 

  //Draw body
  rect(fishX, fishY, fishWidth, fishHeight); 

  //Coordinates of eye
  int eyeX = fishX + fishWidth / 2;
  int eyeY = fishY + fishHeight / 2;

  //Diameter of eye
  int eyeDiameter = 10;

  //RGB colour codes for eye
  color eyeRGB = color(0, 255, 0);

  //Set the eye colour
  fill(eyeRGB);
  
  //Draw the eye
  ellipse (eyeX, eyeY, eyeDiameter, eyeDiameter);

  //Draw spiky tail
  stroke(0);
  for (int tail = fishY; tail <= fishY + fishHeight; tail += fishHeight / 4) {
    line(fishX, fishY + fishHeight / 2, fishX - fishWidth, tail);
  }
  noStroke();
}

/*
  drawBarriers()
  - Draw barriers on screen.
*/
void drawBarriers() {
  rectMode(CORNER);

  for(int barrier = 0; barrier < N_BARRIERS; ++barrier) {
    if(isFood[barrier])
        fill(0, 255, 0);
    else
      fill(255, 0, 0);

    if(!hasBeenEaten[barrier])
      rect(x[barrier], y[barrier], barrierWidth, barrierHeight);
  }
}

void gameOver() {
  gameOver = true;

  noLoop();

  messageBox(0, 210, width/2, height/2, 220, 80);
 
  //Display game over message
  textAlign(CENTER);
  displayText("Game Over", width/2, height/2, pausedSize, pausedColour);

  //textAlign(LEFT);
  displayText("Score: " + playerScore, width/2, height/2 + 17, 16, pausedColour);
  displayText("High Score: " + highScore, width/2, height/2 + 30, 16, pausedColour);
  textAlign(LEFT);

  if(playerScore > highScore)
    highScore = playerScore;
}

void messageBox(color rgb, float opacity, int posX, int posY, int boxHeight, int boxWidth) {
  rectMode(CENTER);
  fill(rgb, opacity);
  rect(posX, posY, boxHeight, boxWidth);
  rectMode(CORNER);
}

void displayStatus(color bgRGB, float bgOpacity, int bgPosX, int bgPosY, int bgWidth, int bgHeight) {
  textAlign(LEFT);
  //Display player score
  fill(bgRGB, bgOpacity);
  rect(bgPosX, bgPosY, bgWidth, bgHeight);
  displayText("Score:", scoreX, scoreY - 3, scoreSize, scoreColour);
  displayText(" " + playerScore, scoreX + 35, scoreY - 3, scoreSize, (playerScore > highScore) ? color(0, 255, 0) : scoreColour);
  displayText("High score: " + highScore, scoreX + 70, scoreY - 3, scoreSize, scoreColour);
  displayText("Time remaining: " + timeLimit + "s", scoreX + 170, scoreY -3, scoreSize, scoreColour);
  displayText("Swimmy Fish by Luke Zimmerer", scoreX + 400, scoreY -3, scoreSize, color(0, 255, 0));
}

/*
  displayText()
  - Display text string.
*/
void displayText(String msg, int textX, int textY, int textSize, color textRGB) {
  //Set text size
  textSize(textSize);
  //Set text colour
  fill(textRGB);
  //Display string msg
  text(msg, textX, textY);
}

void pauseGame(int pausedX, int pausedY, int pausedSize, color pausedColour) {
  noLoop();

  messageBox(0, 210, width/2, height/2, 220, 80);

  //Display paused message
  textAlign(CENTER);
  displayText("Paused", pausedX, pausedY, pausedSize, pausedColour);
  displayText("Click to resume!", pausedX, pausedY + 17, 16, pausedColour);
  textAlign(LEFT);
}

void displayMenu() {
  background(bgRGB);

  drawBarriers();

  rectMode(CENTER);
  textAlign(CENTER);

  textFont(font);

  fill(25, 230);
  rect(width/2, height/2, width - 100, height - 150);

  fill(25, 150);
  rect(width/2, height/2 - 88, 470, 50);

  fill(255);
  
  text("Swimmy Fish", width/2, 120);

  fill(0, 255, 0);
  textSize(20);
  
  if(timer % 120 == 0)
    resetBarriers();
  
  timer++;

  displayDifficulty(difficultyLevel);

  fill(255);
  textSize(18);
  text("Click to play!", width/2, 250);

  fill(0, 255, 0);
  textSize(14);
  text("Developed by Luke Zimmerer", width/2, height/2 + 100);

  rectMode(CORNER);
}

void displayDifficulty(int difficulty) {
    text("< " + difficultyLevels[difficulty] + ": " + (100 - N_FOODS) + "% " + "barrier, " + N_FOODS + "% food, " + FISH_SPEED * 50 + "% speed >", width/2, 200);

    if(difficulty == 6) {
      textSize(16);
      text("Barriers randomly generate every 2 seconds!", width/2, 220);
    }
}

/*
  resetBarriers()
  - Reset barrier coordinates
*/
void resetBarriers() {
  //Generate new barrier coordinates
  for(int barrier = 0; barrier < N_BARRIERS; ++barrier) {
    //Reset hasBeenEaten[] values
    hasBeenEaten[barrier] = false;

    //Generate food blocks
    isFood[barrier] = (random(100) < N_FOODS) ? true : false;

    //Generate new barrier coordinates
    x[barrier] = (int)random(1, width/barrierWidth) * barrierWidth;
    y[barrier] = (int)random(0, height/barrierHeight) * barrierHeight;
  }
}

void loadNextLevel() {
  resetBarriers();

  fishX = 0 - fishWidth;

  playerScore += SCORE_WIN;
}

void killFish() {
  resetBarriers();

  fishX = 0 - fishWidth;
  fishY = (int)random(0, height/fishHeight) * fishHeight;

  playerScore -= SCORE_LOSE;
}

void eatFood(int food) {
  hasBeenEaten[food] = true;

  playerScore += SCORE_FOOD;
}

void newGame() {
  gameOver = false;
  
  resetBarriers();

  fishX = 0 - fishWidth;
  fishY = (int)random(0, height/fishHeight) * fishHeight;

  playerScore = 0;
  timeLimit = 30;

  loop();
}

/*
  hasFishWon()
  - Check if fish has left the screen.
*/
boolean hasFishWon() {
  if(fishX == width + fishWidth * 2)
    return true;
  else
    return false;
}

/*
  hasFishHit()
  - Check if fish has hit a barrier.
*/
boolean hasFishHit(int barrier) {
  if(fishX >= x[barrier] - fishWidth && fishX < x[barrier] + fishWidth && fishY == y[barrier])
    return true;
  else
    return false;
}

void changeDifficulty(int newDifficulty) {
  N_FOODS = foodRatios[difficultyLevel];
  FISH_SPEED = fishSpeeds[difficultyLevel];
}

/*
  mousePressed()
  - Execute if mouse button is pressed.
*/
void mousePressed() {
  if(gameStart) {
    if(gameOver) {
      gamePaused = false;
      newGame();
    }

    else {
      gamePaused = !gamePaused;
      loop();
    }
  }

  else
    gameStart = true;
}

/*
  keyPressed()
  - Execute if key is pressed.
*/
void keyPressed() {
  if(key == CODED) {
    if(!gameStart) {
      if(keyCode == RIGHT && difficultyLevel < maxDifficulty) {
        changeDifficulty(difficultyLevel++);
        //resetBarriers();
      }

      else if(keyCode == LEFT && difficultyLevel > minDifficulty) {
        changeDifficulty(difficultyLevel--);
        //resetBarriers();
      }
      
    }

    else {
      if(keyCode == UP)
        fishY -= (fishY > 0) ? fishHeight : 0;
      else if(keyCode == DOWN)
        fishY += (fishY < height - fishHeight) ? fishHeight : 0;
    }
  }
}
