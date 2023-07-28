class Wrapper<T> {
  private T value;
  
  Wrapper(T value) {
    this.value = value;
  }
  
  void setValue(T value) {
    this.value = value;
  }
  
  T getValue(){
    return value;
  }
}
