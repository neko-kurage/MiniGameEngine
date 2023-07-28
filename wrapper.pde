class Wrapper<T extends Number> {
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

class BoolWrapper {
  private boolean bool = false;
  
  BoolWrapper() {
  }
  
  BoolWrapper(boolean bool) {
    this.bool = bool;
  }
  
  void setBool(boolean bool) {
    this.bool = bool;
  }
  
  boolean isTrue() {
    return bool;
  }
}
