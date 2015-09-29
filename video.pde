
//This mirrowing of the video copied straight from the lecture examples. 
void drawVideo () {
  if (cam.available() == true) cam.read();
  image(cam, 0, 0);

  PImage mirror = createImage(cam.width, cam.height, RGB);   
  cam.loadPixels();
  mirror.loadPixels();
  for (int x=0; x<cam.width; x++)
    for (int y=0; y<cam.height; y++)
    {
      int loc = x + y*cam.width;
      int mirrorloc = (cam.width-1 - x) + y*cam.width;
      mirror.pixels[mirrorloc] = cam.pixels[loc];      

      {
        int pix = cam.pixels[loc];
        float r = red(pix);
        float g = green(pix);
        float b = blue(pix);
        mirror.pixels[mirrorloc] = color(r, g, b);
      }
    }
  mirror.updatePixels();  
  image(mirror, 0, 0);
}

//Seaches the row of 11 brightest pixels in the video. BrightestX and brightestY mark the center of this brightest row.
void brightest() {
  float brightestValue = 0;
  int index = 0;
  for (int y = 0; y < cam.height; y++) {
    for (int x = 0; x < cam.width; x++) {
      float brightnesses = 0;
      for (int p = index-5; p < index + 6; p++) {
        int pixelValue = cam.pixels[index];
        brightnesses += brightness(pixelValue);        
      }
      float averageBrightness = brightnesses/11;
      if (averageBrightness > brightestValue) {
        brightestValue = averageBrightness;
        brightestY = y;
        brightestX = x;
      }
      index++;
    }
  }
}

