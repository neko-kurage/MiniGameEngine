class Wrapper<V extends Number> {
  private V value;
  
  void setValue(V value) {
    this.value = value;
  }
  
  V getValue(){
    return value;
  }
}
