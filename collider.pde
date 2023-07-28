abstract class Collider2D {
  Entity parentNode;
  PVector position = new PVector(0, 0);
  
  
  Collider2D() {};
  Collider2D(PVector setPosition) {
    this.position = setPosition;
  }
  
  void setParentNode(Entity parentNode) {
    this.parentNode = parentNode;
  };  

  void update() {
    if(parentNode == null) return;
    this.position = parentNode.position;
  }
}

class PointCollider extends Collider2D {
    PointCollider(PVector setPosition) {
        super(setPosition);
    }
}

class RectangleCollider extends Collider2D {
  float myWidth, myHeight;
  
  RectangleCollider(PVector setPosition, float setWidth, float setHeight) {
    super(setPosition);
    this.myWidth = setWidth;
    this.myHeight = setHeight;
  }
  
  float getTop() { return this.position.y; }
  float getBottom() { return this.position.y + this.myHeight; }
  float getLeft() { return this.position.y; }
  float getRight() { return this.position.y + this.myWidth; }
}

class CircleCollider extends Collider2D {
    float radius;
  
    CircleCollider(PVector setPosition, float radius) {
      super(setPosition);
      this.radius = radius;
    }

    float getRadius() { return this.radius; }
}

class CollisionDetector {
    boolean detectCollision(Collider2D colliderA, Collider2D colliderB) {
      if (colliderA instanceof RectangleCollider && colliderB instanceof RectangleCollider) {
          return this.detectRectanglesCollision((RectangleCollider) colliderA, (RectangleCollider) colliderB);
      }
  
      if (colliderA instanceof CircleCollider && colliderB instanceof PointCollider) {
          return this.detectCircleAndPointCollision((CircleCollider) colliderA, (PointCollider) colliderB);
      } else if (colliderA instanceof PointCollider && colliderB instanceof CircleCollider) {
          return this.detectCircleAndPointCollision((CircleCollider) colliderB, (PointCollider) colliderA);
      }
  
      return false;
    }
    
    boolean detectRectanglesCollision(RectangleCollider rect1, RectangleCollider rect2) {
        boolean horizontal = (rect2.getLeft() < rect1.getRight()) && (rect1.getLeft() < rect2.getRight());
        boolean vertical = (rect2.getTop() < rect1.getBottom()) && (rect1.getTop() < rect2.getBottom());
        return (horizontal && vertical);
    }

    boolean detectCirclesCollision() {
        return false;
    }

    boolean detectCircleAndPointCollision(CircleCollider circle, PointCollider point){
        float d = dist(circle.position.x, circle.position.y, point.position.x, point.position.y);
        return (d < circle.radius);
    }
}
