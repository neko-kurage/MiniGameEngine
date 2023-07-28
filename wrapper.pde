class Wrapper<V extends Number>{
  private V value = (V) Integer.valueOf(0);
  
  void setValue(V value) {
    this.value = value;
  }
  
  V getValue(){
    return value;
  }
}
