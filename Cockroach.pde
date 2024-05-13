/**
 * Animated Sprite (Shifty + Teddy)
 * by James Paterson. 
 * 
 * Press the mouse button to change animations.
 * Demonstrates loading, displaying, and animating GIF images.
 * It would be easy to write a program to display 
 * animated GIFs, but would not allow as much control over 
 * the display sequence and rate of display. 
 */

Animation animation1, animation2;

float xpos;
float ypos;
float drag = 30.0;

void setup() {
  size(1080, 640);
  background(255, 255, 255);
  frameRate(20);
  animation1 = new Animation("frame", 8, 0.25, 0.25);
  ypos = height * 0.25;
}

void draw() { 
  float dx = mouseX - xpos;
  xpos = xpos + dx/drag;

  // Display the sprite at the position xpos, ypos
    background(255, 255, 255);
    animation1.display(xpos-animation1.getWidth()/2, ypos);
}
