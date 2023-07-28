abstract class Geometry implements Displayable {
  ArrayList<PVector> vertices = new ArrayList<PVector>();
  color fillColor = color(255);
  float strokeWeight = 4;
  color strokeColor = color(30);
  
  void display() {};
}

class GeometryPyramid extends Geometry {
  GeometryPyramid(float myWidth, float myDepth, float myHeight) {
    this.vertices.add(new PVector(myWidth / 2, myHeight / 2, myDepth / 2));
    this.vertices.add(new PVector(myWidth / 2, myHeight / 2, -myDepth / 2));
    this.vertices.add(new PVector(-myWidth / 2, myHeight / 2, -myDepth / 2));
    this.vertices.add(new PVector(-myWidth / 2, myHeight / 2, myDepth / 2));
    this.vertices.add(new PVector(0, -myHeight / 2, 0));
  }
  
  void display() {
    fill(fillColor);
    strokeWeight(2);
    stroke(strokeColor);
 
    beginShape(QUADS);
      for(int i = 0; i < 4; i++) {
        vertex(this.vertices.get(i).x, this.vertices.get(i).y, this.vertices.get(i).z);
      }
    endShape();
    beginShape(TRIANGLES);
      for(int i = 0; i < 4; i++) {
        if(i == 3) {
          vertex(this.vertices.get(i).x, this.vertices.get(i).y, this.vertices.get(i).z);
          vertex(this.vertices.get(0).x, this.vertices.get(0).y, this.vertices.get(0).z);
          vertex(this.vertices.get(4).x, this.vertices.get(4).y, this.vertices.get(4).z);
        } else {
          vertex(this.vertices.get(i).x, this.vertices.get(i).y, this.vertices.get(i).z);
          vertex(this.vertices.get(i + 1).x, this.vertices.get(i + 1).y, this.vertices.get(i + 1).z);
          vertex(this.vertices.get(4).x, this.vertices.get(4).y, this.vertices.get(4).z);
        }
      }
    endShape();
  }
}

class GeometryBox extends Geometry {
  float myWidth;
  float myDepth;
  float myHeight;
  
  GeometryBox(float setWidth, float setDepth, float setHeight) {
    this.myWidth = setWidth;
    this.myDepth =  setDepth;
    this.myHeight = setHeight;
  }
  
  void display() {
    fill(fillColor);
    strokeWeight(2);
    stroke(strokeColor);
    box(this.myWidth, this.myHeight, this.myDepth);
  }
}
