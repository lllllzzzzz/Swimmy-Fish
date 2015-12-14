/*
  Swimmy Fish - Global Variables
*/

// Constants
int N_BARRIERS = 15;
final int BLOCKS_TO_MOVE = 15;
final int LANES = 10;
final int SCORE_WIN = 3;
final int SCORE_LOSE = 3;
final int SCORE_FOOD = 1;
int FISH_SPEED = 2;

int N_FOODS = 30;

boolean gameStart = false;

String[] difficultyLevels = {
  "Very Easy", "Easy", "Normal", "Hard", "Very Hard", "Impossible", "Bonus" 
};
int maxDifficulty = difficultyLevels.length - 1;
int minDifficulty = 1;

int[] foodRatios = {
  90, 70, 30, 15, 5, 1, 30
};

int[] fishSpeeds = {
  1, 1, 2, 3, 4, 10, 2
};

int[] totalBarriers = {
  7, 12, 15, 20, 35, 50
};

PFont font = createFont("Cambria", 28);

int timeLimit = 30;
int timer = 0;

// Fish dimensions
final int fishWidth = 40;
final int fishHeight = 40;
// Barrier dimensions
final int barrierWidth = fishWidth;
final int barrierHeight = fishHeight;

// The current position of the fish
int fishX;
int fishY;

int difficultyLevel = 2;

// Player score
int playerScore = 0;
// High score
int highScore = 0;
// Is game paused?
boolean gamePaused = false;
// Is game over?
boolean gameOver = false;

// Coordinates to display score
final int scoreX = 10;
final int scoreY = 17;
// Text size of score
final int scoreSize = 13;
// Colour of score
final int scoreColour = color(255);

// Coordinates to display paused message
final int pausedX = 0;
final int pausedY = height/2;
// Text size of paused message
final int pausedSize = 30;
// Colour of paused message
final int pausedColour = color(255);

// Coordinates of barriers stored in float arrays
float[] x = new float[N_BARRIERS];
float[] y = new float[N_BARRIERS];

// Boolean flags stored in arrays
boolean[] isFood = new boolean[N_BARRIERS];
boolean[] hasBeenEaten = new boolean[N_BARRIERS];

// RGB colour codes for background
final color bgRGB = color(89, 181, 188);
// RGB colour codes of fish body
final color fishRGB = color(0, 0, 255);
