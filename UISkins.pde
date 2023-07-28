abstract class UISkin {
  UIEntity parentNode;
  
  color fillColor = color(60, 0, 0);
  float strokeWeight = 0;
  color strokeColor = color(0);
  
  color startFillColor = color(60, 0, 0);
  float startStrokeWeight = 0;
  color startStrokeColor = color(255, 0, 0);
  
  color hoverFillColor = color(120, 0, 0);
  float hoverStrokeWeight = 0;
  color hoverStrokeColor = color(200, 0, 0);

  void setParentNode(UIEntity parentNode) {
    this.parentNode = parentNode;
  };
  
  UISkin() {}  
  UISkin(color startFillColor, float startStrokeWeight, color startStrokeColor) {
    this.startFillColor = startFillColor;
    this.startStrokeWeight = startStrokeWeight;
    this.startStrokeColor = startStrokeColor;
  }
  
  void setHoverStyle(color startFillColor, float startStrokeWeight, color startStrokeColor) {
    this.startFillColor = startFillColor;
    this.startStrokeWeight = startStrokeWeight;
    this.startStrokeColor = startStrokeColor;
  }
  
  void update() {};
  void display() {};
}

/*
You can retrieve the hover state as a string using parentNode.getHoverState().
There are four possible hover states: "hovered," "hoverExit," "hovering," "hoverOff."
*/

//Sumple
class SkinCircleButton extends UISkin {
  float radius = 60;
  float startRadius = 60;
  float hoverRadius = 80;
  
  Easing easing = new EasingInOutCubic();
  int duration = 600;
  Tween tweenRadius = new Tween(this.startRadius, this.hoverRadius, this.duration, this.easing);
  Tween tweenFillColor = new Tween(this.startFillColor, this.hoverFillColor, this.duration, this.easing);
  Tween tweenStrokeWeight = new Tween(this.startStrokeWeight, this.hoverStrokeWeight, this.duration, this.easing);
  Tween tweenStrokeColor = new Tween(this.startStrokeColor, this.hoverStrokeColor, this.duration, this.easing);
  
  SkinCircleButton() {}

  SkinCircleButton(float startRadius) {
    this.startRadius = startRadius;
    setTween();
  }
  
  SkinCircleButton(float startRadius, color startFillColor) {
    this.startRadius = startRadius;
    this.startFillColor = startFillColor;
    setTween();
  }
  
  SkinCircleButton(float startRadius, color startFillColor, float startStrokeWeight) {
    this.startRadius = startRadius;
    this.startFillColor = startFillColor;
    this.startStrokeWeight = startStrokeWeight;
    setTween();
  }
  
  SkinCircleButton(float startRadius, color startFillColor, float startStrokeWeight, color startStrokeColor) {
    this.startRadius = startRadius;
    this.startFillColor = startFillColor;
    this.startStrokeWeight = startStrokeWeight;
    this.startStrokeColor = startStrokeColor;
    setTween();
  }
  
  void setHoverStyle(float startRadius) {
    this.hoverRadius = startRadius;
    setTween();
  }
  
  void setHoverStyle(float startRadius, color startFillColor) {
    this.hoverRadius = startRadius;
    this.hoverFillColor = startFillColor;
    setTween();
  }
  
  void setHoverStyle(float startRadius, color startFillColor, float startStrokeWeight) {
    this.hoverRadius = startRadius;
    this.hoverFillColor = startFillColor;
    this.hoverStrokeWeight = startStrokeWeight;
    setTween();
  }
  
  void setHoverStyle(float startRadius, color startFillColor, float startStrokeWeight, color startStrokeColor) {
    this.hoverRadius = startRadius;
    this.hoverFillColor = startFillColor;
    this.hoverStrokeWeight = startStrokeWeight;
    this.hoverStrokeColor = startStrokeColor;
    setTween();
  }
  
  void setTween() {
    tweenRadius = new Tween(this.startRadius, this.hoverRadius, this.duration, this.easing);
    tweenFillColor = new Tween(new float[]{this.startFillColor}, new float[]{this.hoverFillColor}, this.duration, this.easing);
    tweenStrokeWeight = new Tween(this.startStrokeWeight, this.hoverStrokeWeight, this.duration, this.easing);
    tweenStrokeColor = new Tween(new float[]{this.startStrokeColor}, new float[]{this.hoverStrokeColor}, this.duration, this.easing);
  }
  
  void setTween(int duration) {
    this.duration = duration;
  }
  
  void setTween(int duration, Easing easing) {
    this.duration = duration;
    this.easing = easing;
  }
  
  void update() {
    if (parentNode.getHoverState().equals("hovered")) {
      tweenRadius = new Tween(this.startRadius, this.hoverRadius, this.duration, this.easing);
      tweenFillColor = new Tween(this.startFillColor, this.hoverFillColor, this.duration, this.easing);
      tweenStrokeWeight = new Tween(this.startStrokeWeight, this.hoverStrokeWeight, this.duration, this.easing);
      tweenStrokeColor = new Tween(this.startStrokeColor, this.hoverStrokeColor, this.duration, this.easing);
      
      tweenRadius.start();
      tweenFillColor.start();
      tweenStrokeWeight.start();
      tweenStrokeColor.start();
    }
    
    if (parentNode.getHoverState().equals("hoverExit")) {
      tweenRadius.reverse();
      tweenFillColor.reverse();
      tweenStrokeWeight.reverse();
      tweenStrokeColor.reverse();
    }
    //println(this.startStrokeColor.getColorComponents()));
    radius = tweenRadius.getValue();
    fillColor = color(tweenFillColor.getValue(), 255, 255);
    strokeWeight = tweenStrokeWeight.getValue();
    strokeColor = color(tweenFillColor.getValue(), 255, 255);
  }
  
  void display() {
    fill(fillColor);
    stroke(strokeColor);
    strokeWeight(strokeWeight);
    if(strokeWeight == 0) noStroke();
    
    circle(parentNode.position.x, parentNode.position.y, radius);
  }
}
