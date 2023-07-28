class Tween<T> extends Timer {
  ArrayList<Float> froms = new ArrayList<Float>();
  ArrayList<Float> tos = new ArrayList<Float>();
  ArrayList<Wrapper<T>> targets = new ArrayList<Wrapper<T>>();
  Easing easing;
  
  Tween(T from, T to, int duration) {
    super(duration);
    
    if (from instanceof Number && to instanceof Number) {
      this.froms.add((Float) from);
      this.tos.add((Float) to);
    } else {
      throw new IllegalArgumentException("引数fromsもしくは引数tosに予期しない型が代入されました");
    }
    
    this.easing = new EasingLinear();
  }
  
  Tween(T from, T to, int duration, Easing easing) {
    super(duration);
    if (from instanceof Number && to instanceof Number) {
      this.froms.add((Float) from);
      this.tos.add((Float) to);
    } else {
      throw new IllegalArgumentException("引数fromsもしくは引数tosに予期しない型が代入されました");
    }
    
    this.easing = easing;
  }

  Tween(T[] froms, T[] tos, int duration) {
    super(duration);

    if(froms.length != tos.length) {
      throw new IllegalArgumentException("引数fromsと引数tosの要素数は同じにしてください");
    }
    
    if (froms[0] instanceof Number && tos[0] instanceof Number) {
      for(int i = 0; i < froms.length; i++) {
        this.froms.add((Float) froms[i]);
        this.tos.add((Float) tos[i]);
      }
    } else {
      throw new IllegalArgumentException("引数fromsもしくは引数tosに予期しない型が代入されました");
    }

    this.easing = new EasingLinear();
  }
  
  Tween(T[] froms, T[] tos, int duration, Easing easing) {
    super(duration);
    
    if (froms[0] instanceof Number && tos[0] instanceof Number) {
      for(int i = 0; i < froms.length; i++) {
        this.froms.add((Float) froms[i]);
        this.tos.add((Float) tos[i]);
      }
    } else {
      throw new IllegalArgumentException("引数fromsもしくは引数tosに予期しない型が代入されました");
    }
    
    this.easing = easing;
  }
  
  Tween(Wrapper<T> target, T from, T to, int duration) {
    super(duration);
    if (from instanceof Number && to instanceof Number) {
      this.froms.add((Float) from);
      this.tos.add((Float) to);
    } else {
      throw new IllegalArgumentException("引数fromsもしくは引数tosに予期しない型が代入されました");
    }
    
    this.targets.add(target);
    this.easing = new EasingLinear();
  }
  
  Tween(Wrapper<T> target, T from, T to, int duration, Easing easing) {
    super(duration);
    if (from instanceof Number && to instanceof Number) {
      this.froms.add((Float) from);
      this.tos.add((Float) to);
    } else {
      throw new IllegalArgumentException("引数fromsもしくは引数tosに予期しない型が代入されました");
    }
    
    this.targets.add(target);
    this.easing = easing;
  }

  Tween(Wrapper<T>[] targets, T[] froms, T[] tos, int duration) {
    super(duration);

    if(targets.length != froms.length && targets.length != tos.length) {
      throw new IllegalArgumentException("引数targets、引数froms、引数tosのそれぞれの要素数は同じにしてください");
    }
    
    if (froms[0] instanceof Number && tos[0] instanceof Number) {
      for(int i = 0; i < froms.length; i++) {
        this.froms.add((Float) froms[i]);
        this.tos.add((Float) tos[i]);
      }
    } else {
      throw new IllegalArgumentException("引数fromsもしくは引数tosに予期しない型が代入されました");
    }
    
    this.easing = new EasingLinear();
  }
  
  Tween(Wrapper<T>[] targets, T[] froms, T[] tos, int duration, Easing easing) {
    super(duration);
    
    if(targets.length != froms.length && targets.length != tos.length) {
      throw new IllegalArgumentException("引数targets、引数froms、引数tosのそれぞれの要素数は同じにしてください");
    }
    
    if (froms[0] instanceof Number && tos[0] instanceof Number) {
      for(int i = 0; i < froms.length; i++) {
        this.froms.add((Float) froms[i]);
        this.tos.add((Float) tos[i]);
      }
    } else {
      throw new IllegalArgumentException("引数fromsもしくは引数tosに予期しない型が代入されました");
    }
    
    this.easing = easing;
  }
  
  float getValue() {
    if(this.isCompleat()) this.stop();
    
    return map(easing.get(getProgress()), 0, 1, this.froms.get(0), this.tos.get(0));
  }
  
  float[] getValues() {
    if(this.isCompleat()) this.stop();
    
    float[] result = new float[this.froms.size()];
    for(int i = 0; i < froms.size(); i++) {
      result[i] = map(easing.get(getProgress()), 0, 1, this.froms.get(i), this.tos.get(i));
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
      targets.get(i).value = (T)(Float) map(easing.get(getProgress()), 0, 1, this.froms.get(i), this.tos.get(i));
    }
  }
}
