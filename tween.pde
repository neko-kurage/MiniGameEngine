class Tween extends Timer {
  float[] froms, tos;
  ArrayList<Wrapper<Float>> targets = new ArrayList<Wrapper<Float>>();
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
    
    if(froms.length != tos.length) {
      throw new IllegalArgumentException("引数fromsと引数tosの要素数は同じにしてください");
    }
    
    this.froms = froms;
    this.tos = tos;
    
    this.easing = easing;
  }
  
  Tween(color from, color to, int duration) {
    super(duration);   
    this.froms = new float[]{red(from), green(from), blue(from), alpha(from)};
    this.tos = new float[]{red(to), green(to), blue(to), alpha(from)};
    
    this.easing = new EasingLinear();
  }
  
  Tween(color from, color to, int duration, Easing easing) {
    super(duration);
    this.froms = new float[]{red(from), green(from), blue(from), alpha(from)};
    this.tos = new float[]{red(to), green(to), blue(to), alpha(to)};
    
    this.easing = easing;
  }
  
  Tween(Wrapper<Float> target, float from, float to, int duration) {
    super(duration);
    this.froms = new float[] { from };
    this.tos = new float[] { to };
    
    this.targets.add(target);
    this.easing = new EasingLinear();
  }
  
  Tween(Wrapper<Float> target, float from, float to, int duration, Easing easing) {
    super(duration);
    this.froms = new float[] { from };
    this.tos = new float[] { to };
    
    this.targets.add(target);
    this.easing = easing;
  }

  Tween(Wrapper<Float>[] targets, float[] froms, float[] tos, int duration) {
    super(duration);

    if(targets.length != froms.length && targets.length != tos.length) {
      throw new IllegalArgumentException("引数targets、引数froms、引数tosのそれぞれの要素数は同じにしてください");
    }
    
    this.froms = froms;
    this.tos = tos;
    
    this.easing = new EasingLinear();
  }
  
  Tween(Wrapper<Float>[] targets, float[] froms, float[] tos, int duration, Easing easing) {
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
  
  color getColor() {
    if(this.isCompleat()) this.stop();
    
    if(froms.length != 4){
      throw new IllegalArgumentException("color型の要素数とfromsの要素数が一致しません。配列の要素数を4つにしてください");
    }
    if(tos.length != 4) {
      throw new IllegalArgumentException("color型の要素数とtosの要素数が一致しません。配列の要素数を4つにしてください");
    }
    
    float[] result = new float[this.froms.length];
    for(int i = 0; i < froms.length; i++) {
      result[i] = map(easing.get(getProgress()), 0, 1, this.froms[i], this.tos[i]);
    }
    
    
    return color(result[0], result[1], result[2], result[3]);
  }
  
  @Override
  void reverse() {
    super.reverse();   
    super.start();
  }
  
  @Override
  void start() {
    super.start();    
    if(this.isReverse()) this.reverse();
  }
  
  void update() {
    if(this.isCompleat()) this.stop();
    
    for(int i = 0; i < this.targets.size(); i++) {
       targets.get(i).setValue(map(easing.get(getProgress()), 0, 1, this.froms[i], this.tos[i]));
    }
  }
}
