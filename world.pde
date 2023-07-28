class World {
  ArrayList<Object> objects = new ArrayList<Object>();
  
  void addObject(Object object) {
    this.objects.add(object);
  }
  
  void display() {
    for(Object object : this.objects) {
      //stroke(random(255), random(255), random(255));
      object.display();
    }
  }
  
  void consoleTest() {
    print(this.objects.get(0).position.x);
  }
}

class Camera {
  float fov;
  PVector position;
  
  Camera() {
    this.fov = radians(60);
    position = new PVector();
    perspective(this.fov, float(width) / float(height), 1.0, 12000);
  }
  
  void setFov(float rad) {
    fov = rad;
    perspective(this.fov, float(width) / float(height), 1.0, 12000);
  }
  
  void setPosition(PVector setPos, PVector atPos) {
    position = setPos;
    camera(position.x, position.y, position.z, // 視点X, 視点Y, 視点Z
         atPos.x, atPos.y, atPos.z, // 中心点X, 中心点Y, 中心点Z
         0.0, 1.0, 0.0);
  }
}

class Object {
  PVector position;
  PVector rotation;
  Geometry geometry;
  
  Object() {
    this.position = new PVector(0, 0, 0);
    this.rotation = new PVector(0, 0, 0);
  }
  
  Object(Geometry myGeometry) {
    this.position = new PVector(0, 0, 0);
    this.rotation = new PVector(0, 0, 0);
    
    this.geometry = myGeometry;
  }
  
  void display() {
    if(geometry == null) return;
    pushMatrix();
      translate(this.position.x, this.position.y, this.position.z);
      rotateX(this.rotation.x);
      rotateY(this.rotation.y);
      rotateZ(this.rotation.z);
      geometry.display();
    popMatrix();
  };
}

class Geometry {
  ArrayList<PVector> vertices;
  
  Geometry() {
    vertices = new ArrayList<PVector>();
  }
  
  void display() {
  }
}

class GeometryPyramid extends Geometry {
  GeometryPyramid(float myWidth, float myDepth, float myHeight) {
    vertices.add(new PVector(myWidth / 2, myHeight / 2, myDepth / 2));
    vertices.add(new PVector(myWidth / 2, myHeight / 2, -myDepth / 2));
    vertices.add(new PVector(-myWidth / 2, myHeight / 2, -myDepth / 2));
    vertices.add(new PVector(-myWidth / 2, myHeight / 2, myDepth / 2));
    vertices.add(new PVector(0, -myHeight / 2, 0));
  }
  
  void display() {
    beginShape(QUADS);
      for(int i = 0; i < 4; i++) {
        vertex(vertices.get(i).x, vertices.get(i).y, vertices.get(i).z);
      }
    endShape();
    beginShape(TRIANGLES);
      for(int i = 0; i < 4; i++) {
        if(i == 3) {
          vertex(vertices.get(i).x, vertices.get(i).y, vertices.get(i).z);
          vertex(vertices.get(0).x, vertices.get(0).y, vertices.get(0).z);
          vertex(vertices.get(4).x, vertices.get(4).y, vertices.get(4).z);
        } else {
          vertex(vertices.get(i).x, vertices.get(i).y, vertices.get(i).z);
          vertex(vertices.get(i + 1).x, vertices.get(i + 1).y, vertices.get(i + 1).z);
          vertex(vertices.get(4).x, vertices.get(4).y, vertices.get(4).z);
        }
      }
    endShape();
  }
}

class Box extends Geometry {
  float myWidth;
  float myDepth;
  float myHeight;
  
  Box(float setWidth, float setDepth, float setHeight) {
    myWidth = setWidth;
    myDepth =  setDepth;
    myHeight = setHeight;
  }
  
  void display() {
    box(myWidth, myHeight, myDepth);
  }
}
