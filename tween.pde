class Tween extends Timer{
  float[] froms, tos;
  Wrapper<Float>[] targets = null;
  Easing easing;
  
  Tween(float from, float to, int duration) {
    super(duration);
    this.froms = new float[] { from };
    this.tos = new float[] { to };
    
    this.easing = new EasingLinear();
  }

  Tween(float[] froms, float[] tos, int duration) {
    super(duration);
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

  Tween(float from, float to, int duration, Easing easing) {
    super(duration);
    this.froms = new float[] { from };
    this.tos = new float[] { to };
    
    this.easing = easing;
  }

  Tween(Wrapper<Float>[] targets, float from, float to, int duration) {
    super(duration);
    this.froms = new float[] { from };
    this.tos = new float[] { to };
    
    this.targets = targets;
    this.easing = new EasingLinear();
  }

  Tween(Wrapper<Float>[] targets, float[] froms, float[] tos, int duration) {
    super(duration);
    this.froms = froms;
    this.tos = tos;
    
    this.targets = targets;
    this.easing = new EasingLinear();
  }

  Tween(Wrapper<Float>[] targets, float[] froms, float[] tos, int duration, Easing easing) {
    super(duration);
    this.froms = froms;
    this.tos = tos;
    
    this.targets = targets;
    this.easing = easing;
  }
  
  float getValue() {
    if(this.isCompleat()) this.stop();
    
    if (froms.length != 1);
    
    return map(easing.get(getProgress()), 0, 1, this.froms[0], this.tos[0]);
  }
  
  float[] getValues() {
    if(this.isCompleat()) this.stop();
    
    float[] result = new float[froms.length];
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
    for(int i = 0; i < targets.length; i++) {
      targets[i].value = map(easing.get(getProgress()), 0, 1, this.froms[i], this.tos[i]);
    }
  }
}
/*
class Tween<T> extends Timer {
  float[] froms, tos;
  Wrapper<Float>[] targets = null;
  Easing easing;
  
  Tween(T from, T to, int duration) {
    super(duration);
    this.froms = new float[] { from };
    this.tos = new float[] { to };
    
    this.easing = new EasingLinear();
  }

  Tween(T[] froms, T[] tos, int duration) {
    super(duration);
    this.froms = froms;
    this.tos = tos;

    this.easing = new EasingLinear();
  }
  
  Tween(T[] froms, T[] tos, int duration, Easing easing) {
    super(duration);
    this.froms = froms;
    this.tos = tos;
    
    this.easing = easing;
  }

  Tween(T from, T to, int duration, Easing easing) {
    super(duration);
    this.froms = new float[] { from };
    this.tos = new float[] { to };
    
    this.easing = easing;
  }

  Tween(Wrapper<T>[] targets, float from, float to, int duration) {
    super(duration);
    this.froms = new float[] { from };
    this.tos = new float[] { to };
    
    this.targets = targets;
    this.easing = new EasingLinear();
  }

  Tween(Wrapper<T>[] targets, float[] froms, float[] tos, int duration) {
    super(duration);
    this.froms = froms;
    this.tos = tos;
    
    this.targets = targets;
    this.easing = new EasingLinear();
  }

  Tween(Wrapper<Float>[] targets, float[] froms, float[] tos, int duration, Easing easing) {
    super(duration);
    this.froms = froms;
    this.tos = tos;
    
    this.targets = targets;
    this.easing = easing;
  }
  
}
*/
