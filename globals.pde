/*
  Swimmy Fish - Global Variables
*/

// Constants/variables
final int BLOCKS_TO_MOVE = 15;
final int LANES          = 10;
final int SCORE_WIN      = 3;
final int SCORE_LOSE     = 3;
final int SCORE_FOOD     = 1;
int       N_BARRIERS     = 15;
int       FISH_SPEED     = 2;
int       N_FOODS        = 30;
boolean   gameStart      = false;

final int fishWidth     = 40;
final int fishHeight    = 40;
final int barrierWidth  = fishWidth;
final int barrierHeight = fishHeight;

int timeLimit = 30;
int timer     = 0;

int fishX, fishY;

int difficultyLevel = 2;
int playerScore     = 0;
int highScore       = 0;
boolean gamePaused  = false;
boolean gameOver    = false;

final int scoreX      = 10;
final int scoreY      = 17;
final int scoreSize   = 13;
final int scoreColour = color(255);

final int pausedX      = 0;
final int pausedY      = height / 2;
final int pausedSize   = 30;
final int pausedColour = color(255);

String[] difficultyLevels = { "Very Easy", "Easy", "Normal", "Hard", "Very Hard", "Impossible", "Bonus" };
int[] foodRatios          = { 90, 70, 30, 15, 5, 1, 30 };
int[] fishSpeeds          = { 1, 1, 2, 3, 4, 10, 2 };
int[] totalBarriers       = { 7, 12, 15, 20, 35, 50 };

int maxDifficulty = difficultyLevels.length - 1;
int minDifficulty = 1;

PFont font = createFont("Cambria", 28);

float[] x = new float[N_BARRIERS];
float[] y = new float[N_BARRIERS];

boolean[] isFood       = new boolean[N_BARRIERS];
boolean[] hasBeenEaten = new boolean[N_BARRIERS];

final color bgRGB   = color(89, 181, 188);
final color fishRGB = color(0, 0, 255);
