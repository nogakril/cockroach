class Animation {
  PImage[] images;
  int imageCount;
  int frame;
  float scaleX;
  float scaleY;
  
  Animation(String imagePrefix, int count, float scaleX, float scaleY) {
    imageCount = count;
    images = new PImage[imageCount];

    for (int i = 0; i < imageCount; i++) {
      // Use nf() to number format 'i' into four digits
      String filename = imagePrefix + nf(i, 1) + ".gif";
      images[i] = loadImage(filename);
      images[i].resize(int(images[i].width * scaleX), int(images[i].height * scaleY));
    }
  }

  void display(float xpos, float ypos) {
    frame = (frame+1) % imageCount;
    image(images[frame], xpos, ypos);
  }
  
  int getWidth() {
    return images[0].width;
  }
}
