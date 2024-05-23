Animation[] animations; // Declare an array of Animation objects

float[] xpos, ypos;     // Arrays for positions
float[] angles;         // Array for angles
float[] speeds;         // Array for movement speeds
int numAnimations = 100; // Number of animations
int padding = 150;

float[] targetDistances;   // Array for target distances from the mouse
int[] moveTimer;           // Timer for moving in a random direction

void setup() {
  size(1920, 1080);
  background(255, 255, 255);
  frameRate(30);

  animations = new Animation[numAnimations];
  xpos = new float[numAnimations];
  ypos = new float[numAnimations];
  angles = new float[numAnimations];
  speeds = new float[numAnimations];
  targetDistances = new float[numAnimations];
  moveTimer = new int[numAnimations];

  for (int i = 0; i < numAnimations; i++) {
    animations[i] = new Animation("frame", 8, 0.25, 0.25);
    xpos[i] = random(width);
    ypos[i] = random(height);
    angles[i] = random(TWO_PI);
    speeds[i] = random(20, 30);
    targetDistances[i] = random(100, 200);
    moveTimer[i] = 0;
  }
}

void draw() { 
  background(255, 255, 255);

  for (int i = 0; i < numAnimations; i++) {
    float dx = mouseX - xpos[i];
    float dy = mouseY - ypos[i];
    float distance = sqrt(dx*dx + dy*dy);

    if (moveTimer[i] > 0) {
      // Continue in random direction
      moveTimer[i]--;
    } else {
      if (distance > targetDistances[i]) {
        // Move towards the mouse if outside the target distance
        angles[i] = atan2(dy, dx);
      } else {
        // Randomize direction and set a random move time
        angles[i] = random(TWO_PI);
        moveTimer[i] = (int) random(60, 120); // Random duration between 1 to 2 seconds at 60 fps
      }
    }

    // Update positions
    xpos[i] += cos(angles[i]) * speeds[i];
    ypos[i] += sin(angles[i]) * speeds[i];

    // Wrap around screen edges
    if (xpos[i] < -padding) xpos[i] = width;
    else if (xpos[i] > width + padding) xpos[i] = 0;
    if (ypos[i] < -padding) ypos[i] = height;
    else if (ypos[i] > height + padding) ypos[i] = 0;

    // Draw and rotate each animation
    translate(xpos[i], ypos[i]);
    rotate(angles[i] + PI);
    animations[i].display(-animations[i].getWidth()/2, -animations[i].getHeight()/2);
    resetMatrix(); // Reset transformations after each animation
  }
}
