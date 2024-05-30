//Animation[] animations; // Declare an array of Animation objects

//float[] xpos, ypos;     // Arrays for positions
//float[] angles;         // Array for angles
//float[] speeds;         // Array for movement speeds
//int numAnimations = 100; // Number of animations
//int padding = 150;

//float[] targetDistances;   // Array for target distances from the mouse
//int[] moveTimer;           // Timer for moving in a random direction

//void setup() {
//  size(1920, 1080);
//  background(255, 255, 255);
//  frameRate(30);

//  animations = new Animation[numAnimations];
//  xpos = new float[numAnimations];
//  ypos = new float[numAnimations];
//  angles = new float[numAnimations];
//  speeds = new float[numAnimations];
//  targetDistances = new float[numAnimations];
//  moveTimer = new int[numAnimations];

//  for (int i = 0; i < numAnimations; i++) {
//    animations[i] = new Animation("frame", 8, 0.25, 0.25);
//    xpos[i] = random(width);
//    ypos[i] = random(height);
//    angles[i] = random(TWO_PI);
//    speeds[i] = random(20, 30);
//    targetDistances[i] = random(100, 200);
//    moveTimer[i] = 0;
//  }
//}

//void draw() { 
//  background(255, 255, 255);

//  for (int i = 0; i < numAnimations; i++) {
//    float dx = mouseX - xpos[i];
//    float dy = mouseY - ypos[i];
//    float distance = sqrt(dx*dx + dy*dy);

//    if (moveTimer[i] > 0) {
//      // Continue in random direction
//      moveTimer[i]--;
//    } else {
//      if (distance > targetDistances[i]) {
//        // Move towards the mouse if outside the target distance
//        angles[i] = atan2(dy, dx);
//      } else {
//        // Randomize direction and set a random move time
//        angles[i] = random(TWO_PI);
//        moveTimer[i] = (int) random(60, 120); // Random duration between 1 to 2 seconds at 60 fps
//      }
//    }

//    // Update positions
//    xpos[i] += cos(angles[i]) * speeds[i];
//    ypos[i] += sin(angles[i]) * speeds[i];

//    // Wrap around screen edges
//    if (xpos[i] < -padding) xpos[i] = width;
//    else if (xpos[i] > width + padding) xpos[i] = 0;
//    if (ypos[i] < -padding) ypos[i] = height;
//    else if (ypos[i] > height + padding) ypos[i] = 0;

//    // Draw and rotate each animation
//    translate(xpos[i], ypos[i]);
//    rotate(angles[i] + PI);
//    animations[i].display(-animations[i].getWidth()/2, -animations[i].getHeight()/2);
//    resetMatrix(); // Reset transformations after each animation
//  }
//}

int padding = 150;
float frameScale = 0.15;
class Mover {
    PVector position;
    PVector velocity;
    float size;
    Animation animation; // Include Animation object

    Mover(Animation anim) {
        this.animation = anim; // Assign the animation
        position = new PVector(random(width), random(height));
        velocity = PVector.random2D();
        velocity.mult(random(4, 7));
        size = max(animation.getWidth(), animation.getHeight()); // Adjust size based on animation dimensions
    }

    void update() {
        position.add(velocity);
        
        // Screen wrapping
        if (position.x > width + padding) position.x = 0;
        if (position.x < -padding) position.x = width;
        if (position.y > height + padding) position.y = 0;
        if (position.y < -padding) position.y = height;
    }

    void display() {
        // Use the animation's display method
        
        float angle = atan2(velocity.y, velocity.x);
        animation.display(position.x, position.y, angle + PI);
    }

    void checkMouse(float mx, float my) {
      int radius = 200;
        PVector mouse = new PVector(mx, my);
        float d = PVector.dist(position, mouse);
        
        // Calculate avoidance force more smoothly
        if (d < radius) { // Increased sensitivity range
            PVector diff = PVector.sub(position, mouse);
            float forceMagnitude = map(d, 0, 200, 20, 0); // Stronger when closer
            diff.normalize();
            diff.mult(forceMagnitude);
            position.add(diff);
        }
    }
}

Mover[] movers;
Animation[] animations; // Array to store animations for each mover

void setup() {
    size(800, 1600);
    int numAnimations = 200;
    int numFrames = 8; // Number of frames per animation
    frameRate(20);
    movers = new Mover[numAnimations];
    animations = new Animation[numAnimations];

    // Load animations
    for (int i = 0; i < numAnimations; i++) {
        animations[i] = new Animation("frame", numFrames, frameScale, frameScale);
    }

    // Initialize movers with animations
    for (int i = 0; i < movers.length; i++) {
        movers[i] = new Mover(animations[i]);
    }
}

void draw() {
    background(255);

    for (int i = 0; i < movers.length; i++) {
        movers[i].update();
        movers[i].checkMouse(mouseX, mouseY);
        movers[i].display();
    }
}

