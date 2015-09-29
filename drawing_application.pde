/*
Vuorovaikutustekniikan studio: harjoitustyö 1A
Johanna Rantanen, 431394
 
 Keys:
 'r' = insert a rectangle
 'e' = insert an ellipse
 Ctrl = resize the selected shape
 Alt = move the selected shape (NOTE: In Windows pressing Alt moves the focus away from Processing frame, therefore you have to click the screen to be able get the focus back)
 Shift = rotate the selected shape
 
 */

import processing.video.*;

Capture cam;

//The brightest pixels in the original video, not mirrowed!
float brightestX = 0;
float brightestY = 0;

ArrayList<Shape> shapes = new ArrayList<Shape>(); //All the shapes drawn are stored here
int selectedIndex = 0;


void setup() {
  size(640, 480);
  cam = new Capture(this, width, height);
  cam.start();
  noStroke();
  ellipseMode(CORNER);
}

void draw() {
  drawVideo();
  for (int i=0; i < shapes.size (); i++) {
    Shape current = shapes.get(i);
    //If the pointer is moved on a shape, the indext of the selected shape is updated to the variable selectedIndex
    if ((width-brightestX-1) >= current.xpos && (width-brightestX-1) < (current.xpos + current.xwidth) && brightestY >= current.ypos && brightestY < (current.ypos + current.yheight)) {
      selectedIndex = i;
      fill(color(30, 50, 200));
    } else {
      fill(color(0, 153, 76));
    }
    current.draw();
  }
  //Draw the red pointer to the brightest part of the video
  brightest();
  ellipseMode(CENTER);
  fill(color(180, 50, 0));
  ellipse(width-brightestX-1, brightestY, 15, 15); //Mirror the pointer
}

//Existing shapes are modified with Ctrl, Alt and Shift
void keyPressed() {
  if (key == CODED) {
    if (keyCode == CONTROL) {
      if (shapes.size() != 0) {
        resize(shapes.get(selectedIndex));
      }
    }
    if (keyCode == ALT) {
      move(shapes.get(selectedIndex));
    }
    if (keyCode == SHIFT) {
      shapes.get(selectedIndex).rotation = (width-brightestX-1)/TWO_PI;
    }
  }
}

//New shapes are added when 'e' or 'r' is released
void keyReleased() {
  if (key == 'r') {
    addShape(true);
  }
  if (key == 'e') {
    addShape(false);
  }
}


void addShape(boolean isRect) {
  Shape newShape = new Shape(isRect, (width-brightestX-1), brightestY, 30, 30, 0);
  shapes.add(newShape);
} 

void resize(Shape resized) {
  resized.xwidth = max(30, (width-brightestX-1)- resized.xpos);
  resized.yheight = max(30, brightestY- resized.ypos);
}

void move(Shape moved) {  
  if ((width-brightestX-1) >= 0 && ((width-brightestX-1)+moved.xwidth) < width && (height-brightestY-1) >= 0 && ((height-brightestY-1) + moved.yheight) < height) {
    moved.xpos = (width-brightestX-1);
    moved.ypos = brightestY;
  }
}

