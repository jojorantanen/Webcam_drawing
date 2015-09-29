//Both rectangles and ellipses are Shapes. Xpos and ypos are the upper left corner of the shape. 

class Shape { 
  boolean rectangle, selected;
  float xpos, ypos, xwidth, yheight, rotation; 
  Shape (boolean rect, float x, float y, float w, float h, float rot) {  
    rectangle = rect;
    xpos = x;
    ypos = y;
    xwidth = w;
    yheight = h;
    rotation = rot;
  } 

  void draw() {
    if (rectangle) {
      if (rotation == 0) {
        rectMode(CORNER);
        rect(xpos, ypos, xwidth, yheight);
      } else {
        //Rotated rectangles are drawn here in the translated coordinate system
        rectMode(CENTER);
        pushMatrix();
        translate(xpos+xwidth/2, ypos+yheight/2);
        rotate(rotation);
        rect(0, 0, xwidth, yheight);
        popMatrix();
        rectMode(CORNER);
      }
    } else {
      if (rotation == 0) {
        ellipseMode(CORNER);
        ellipse(xpos, ypos, xwidth, yheight);
      } else {
        //Rotated ellipses are drawn here in the translated coordinate system
        ellipseMode(CENTER);
        pushMatrix();
        translate(xpos+xwidth/2, ypos+yheight/2);
        rotate(rotation);
        ellipse(0, 0, xwidth, yheight);
        popMatrix();
        ellipseMode(CORNER);
      }
    }
  }
} 

