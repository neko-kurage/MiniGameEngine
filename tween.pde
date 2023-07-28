class Tween extends Timer{
  float from, to;
  Wrapper<Float> target = null;
  Easing easing;
  
  Tween(float from, float to, int duration) {
    super(duration);
    this.from = from;
    this.to = to;
    
    this.easing = new EasingLinear();
  }
  
  Tween(float from, float to, int duration, Easing easing) {
    super(duration);
    this.from = from;
    this.to = to;
    
    this.easing = easing;
  }
  
  Tween(Wrapper<Float> target, float from, float to, int duration) {
    super(duration);
    this.from = from;
    this.to = to;
    
    this.target = target;
    this.easing = new EasingLinear();
  }
  
  Tween(Wrapper<Float> target, float from, float to, int duration, Easing easing) {
    super(duration);
    this.from = from;
    this.to = to;
    
    this.target = target;
    this.easing = easing;
  }
  
  float getValue() {
    if(this.isCompleat()) this.stop();
    return map(easing.get(getProgress()), 0, 1, this.from, this.to);
  }
  
  @Override
  void reverse() {
    super.reverse();
    this.start();
  }
  
  void update() {
    target.value = map(easing.get(getProgress()), 0, 1, this.from, this.to);
  }
}
