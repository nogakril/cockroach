Animation[] animations; // Declare an array of Animation objects

float[] xpos, ypos;     // Arrays for positions
float[] angles;         // Array for angles
float[] speeds;         // Array for movement speeds
int numAnimations = 5; // Number of animations

void setup() {
  size(1080, 640);
  background(255, 255, 255);
  frameRate(20);

  animations = new Animation[numAnimations]; // Initialize the array
  xpos = new float[numAnimations];           // Initialize x positions array
  ypos = new float[numAnimations];           // Initialize y positions array
  angles = new float[numAnimations];         // Initialize angles array
  speeds = new float[numAnimations];         // Initialize speeds array

  for (int i = 0; i < numAnimations; i++) {
    animations[i] = new Animation("frame", 8, 0.25, 0.25); // Initialize each Animation object
    xpos[i] = random(width);                              // Set random initial x position
    ypos[i] = random(height);                             // Set random initial y position
    angles[i] = random(TWO_PI);                           // Set random initial angle
    speeds[i] = random(3, 10);                            // Set random speed for faster movement
  }
}

void draw() { 
  background(255, 255, 255);

  for (int i = 0; i < numAnimations; i++) {
    // Update positions based on set speed and direction
    if (i == 0) {
      // Specific logic for animation[0] to follow the mouse
      float dx = mouseX - xpos[i];
      float dy = mouseY - ypos[i];
      angles[i] = atan2(dy, dx);
      xpos[i] += cos(angles[i]) * 15;
      ypos[i] += sin(angles[i]) * 15;
    } else {
    xpos[i] += cos(angles[i]) * speeds[i];
    ypos[i] += sin(angles[i]) * speeds[i];
  }

    // Wrap around screen edges
    if (xpos[i] < 0) xpos[i] = width;
    else if (xpos[i] > width) xpos[i] = 0;
    if (ypos[i] < 0) ypos[i] = height;
    else if (ypos[i] > height) ypos[i] = 0;

    // Draw and rotate each animation
    translate(xpos[i], ypos[i]);
    rotate(angles[i] + PI);
    animations[i].display(-animations[i].getWidth()/2, -animations[i].getHeight()/2);
    resetMatrix(); // Reset transformations after each animation
  }
}
