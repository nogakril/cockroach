import ddf.minim.*;

Minim minim;
AudioPlayer player;
Mover[] movers;
Animation[] animations; // Array to store animations for each mover
int numAnimations = 200;
int numFrames = 8; // Number of frames per animation
int padding = 150; // Size of animation
float frameScale = 0.07;
int radius = 300;
int force = 200;

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
        PVector mouse = new PVector(mx, my);
        float d = PVector.dist(position, mouse);
        
        // Calculate avoidance force more smoothly
        if (d < radius) { // Increased sensitivity range
            PVector diff = PVector.sub(position, mouse);
            float forceMagnitude = map(d, 0, force, 20, 0); // Stronger when closer
            diff.normalize();
            diff.mult(forceMagnitude);
            position.add(diff);
        }
    }
}


void setup() {
    size(800, 1600); // Ignore when merging the code
    minim = new Minim(this);
  
    // Load the sound file from the 'data' folder
    player = minim.loadFile("cockroachrun.mp3");
    
    // Play the sound file
    player.loop();


    frameRate(30);
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

void stop() {
  // Close the player and Minim when the sketch stops
  player.close();
  minim.stop();
  
  super.stop();
}
