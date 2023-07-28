class Tween extends Timer {
  float[] froms, tos;
  ArrayList<Wrapper<? extends Number>> targets = new ArrayList<Wrapper<? extends Number>>();
  Easing easing;
  
  Tween(float from, float to, int duration) {
    super(duration);
    this.froms = new float[] { from };
    this.tos = new float[] { to };
    
    this.easing = new EasingLinear();
  }
  
  Tween(float from, float to, int duration, Easing easing) {
    super(duration);
    this.froms = new float[] { from };
    this.tos = new float[] { to };
    
    this.easing = easing;
  }

  Tween(float[] froms, float[] tos, int duration) {
    super(duration);

    if(froms.length != tos.length) {
      throw new IllegalArgumentException("引数fromsと引数tosの要素数は同じにしてください");
    }
    
    this.froms = froms;
    this.tos = tos;

    this.easing = new EasingLinear();
  }
  
  Tween(float[] froms, float[] tos, int duration, Easing easing) {
    super(duration);
    
    this.froms = froms;
    this.tos = tos;
    
    this.easing = easing;
  }
  
  Tween(Wrapper<? extends Number> target, float from, float to, int duration) {
    super(duration);
    this.froms = new float[] { from };
    this.tos = new float[] { to };
    
    this.targets.add(target);
    this.easing = new EasingLinear();
  }
  
  Tween(Wrapper<? extends Number> target, float from, float to, int duration, Easing easing) {
    super(duration);
    this.froms = new float[] { from };
    this.tos = new float[] { to };
    
    this.targets.add(target);
    this.easing = easing;
  }

  Tween(Wrapper<? extends Number>[] targets, float[] froms, float[] tos, int duration) {
    super(duration);

    if(targets.length != froms.length && targets.length != tos.length) {
      throw new IllegalArgumentException("引数targets、引数froms、引数tosのそれぞれの要素数は同じにしてください");
    }
    
    this.froms = froms;
    this.tos = tos;
    
    this.easing = new EasingLinear();
  }
  
  Tween(Wrapper<? extends Number>[] targets, float[] froms, float[] tos, int duration, Easing easing) {
    super(duration);
    
    if(targets.length != froms.length && targets.length != tos.length) {
      throw new IllegalArgumentException("引数targets、引数froms、引数tosのそれぞれの要素数は同じにしてください");
    }
    
    this.froms = froms;
    this.tos = tos;
    
    this.easing = easing;
  }
  
  float getValue() {
    if(this.isCompleat()) this.stop();
    
    return map(easing.get(getProgress()), 0, 1, this.froms[0], this.tos[0]);
  }
  
  float[] getValues() {
    if(this.isCompleat()) this.stop();
    
    float[] result = new float[this.froms.length];
    for(int i = 0; i < froms.length; i++) {
      result[i] = map(easing.get(getProgress()), 0, 1, this.froms[i], this.tos[i]);
    }
    
    return result;
  }
  
  @Override
  void reverse() {
    super.reverse();
    this.start();
  }
  
  void update() {
    for(int i = 0; i < this.targets.size(); i++) {
      if(targets.get(i).getValue() instanceof Integer) {
        targets.get(i).setValue(map(easing.get(getProgress()), 0, 1, this.froms[i], this.tos[i]));
      }
    }
  }
}
