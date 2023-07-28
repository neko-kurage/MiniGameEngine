class InputKey implements EventTrigger {
  //Character = watch input key
  //String = triggerType
  HashMap<Character, String> triggerKeys = new HashMap<Character, String>();  
  final HashSet<String> triggerTypes = new HashSet<String>() {{
    add("pressed");
    add("released");
    add("down");
    add("up");
  }};
  
  InputKey(char triggerKey, String triggerType) {
    checkTriggerTypeValidity(triggerType);
    
    this.triggerKeys.put(triggerKey, triggerType);
  }
  
  void addInputKey(char triggerKey, String triggerType) {  
    checkTriggerTypeValidity(triggerType);
    this.triggerKeys.put(triggerKey, triggerType);
  }
  
  void removeInputKey(char triggerKey) {  
    this.triggerKeys.remove(triggerKey);
  }
  
  boolean isFireCondition() {
    for(char triggerKey : this.triggerKeys.keySet()) {
      if (this.triggerKeys.get(triggerKey).equals("pressed")) {
        if(WatchKey.getKeyState(triggerKey).equals("pressed")) return true;
      }
      
      if (this.triggerKeys.get(triggerKey).equals("released")) {
        if(WatchKey.getKeyState(triggerKey).equals("released")) return true;
      }
      
      if (this.triggerKeys.get(triggerKey).equals("down")) {
        if(
          WatchKey.getKeyState(triggerKey).equals("pressed") ||
          WatchKey.getKeyState(triggerKey).equals("down")
        ) {
          return true;
        }
      }
      
      if (this.triggerKeys.get(triggerKey).equals("up")) {
        if(WatchKey.getKeyState(triggerKey).equals("up")) return true;
      }
    }
    
    return false;
  }
  
  private void checkTriggerTypeValidity(String triggerType) {
    if(!this.triggerTypes.contains(triggerType)) {
      throw new IllegalArgumentException("不正な値が入力されています。引数triggerTypeに" + this.triggerTypes.toString() + "以外を代入しないでください。");
    }
  }
}

class KeyPressed implements EventTrigger {
   boolean isFireCondition() {
     if(WatchKey.checkKeyPressed()) return true;
     return false;
   }
   
   void dispatch(){};
}

class KeyDown implements EventTrigger {
   boolean isFireCondition() {
     if(WatchKey.checkKeyDown()) return true;
     return false;
   }
   
   void dispatch(){};
}

class KeyReleased implements EventTrigger {
   boolean isFireCondition() {
     if(WatchKey.checkKeyReleased()) return true;
     return false;
   }
}

class InputMouse implements EventTrigger {
  //Character = watch input mouse
  //String = triggerType
  HashMap<Integer, String> triggerMouseButtons = new HashMap<Integer, String>();
  
  //Integer = getMouseStateにintで入力された場合の対応表。37,39,3以外の数字はcheckInputMouseTypeValidity()ではじく。
  //String = 文字で入力された場合にも対応出来るように
  final HashMap<Integer, String> inputMouseTypes = new HashMap<Integer, String>() {{
    put(37, "left");
    put(39, "right");
    put(3, "center");
  }};
  
  HashSet<String> triggerTypes = new HashSet<String>() {{
    add("pressed");
    add("released");
    add("down");
    add("up");
  }};
  
  InputMouse(int triggerMouseButton, String triggerType) {
    checkTriggerTypeValidity(triggerType);
    
    this.triggerMouseButtons.put(triggerMouseButton, triggerType);
  }
  
  InputMouse(String triggerMouseButton, String triggerType) {
    checkTriggerTypeValidity(triggerType);
    
    this.triggerMouseButtons.put(getKey(inputMouseTypes, triggerMouseButton), triggerType);
  }
  
  void addMouseButton(int triggerMouseButton, String triggerType) {  
    checkTriggerTypeValidity(triggerType);
    this.triggerMouseButtons.put(triggerMouseButton, triggerType);
  }
  
  void addMouseButton(String triggerMouseButton, String triggerType) {  
    checkTriggerTypeValidity(triggerType);
    this.triggerMouseButtons.put(getKey(inputMouseTypes, triggerMouseButton), triggerType);
  }
  
  void removeMouseButton(int triggerMouseButton, String triggerType) {  
    checkTriggerTypeValidity(triggerType);
    this.triggerMouseButtons.put(triggerMouseButton, triggerType);
  }
  
  void removeMouseButton(String triggerMouseButton) {  
    this.triggerMouseButtons.remove(getKey(inputMouseTypes, triggerMouseButton));
  }
  
  boolean isFireCondition() {
    for(int triggerMouseButton : this.triggerMouseButtons.keySet()) {
      if (this.triggerMouseButtons.get(triggerMouseButton).equals("pressed")) {
        if(WatchMouse.getMouseState(triggerMouseButton).equals("pressed")) return true;
      }
      
      if (this.triggerMouseButtons.get(triggerMouseButton).equals("released")) {
        if(WatchMouse.getMouseState(triggerMouseButton).equals("released")) return true;
      }
      
      if (this.triggerMouseButtons.get(triggerMouseButton).equals("down")) {
        if(
          WatchMouse.getMouseState(triggerMouseButton).equals("pressed") ||
          WatchMouse.getMouseState(triggerMouseButton).equals("down")
        ) {
          return true;
        }
      }
      
      if (this.triggerMouseButtons.get(triggerMouseButton).equals("up")) {
        if(WatchMouse.getMouseState(triggerMouseButton).equals("up")) return true;
      }
    }
    
    return false;
  }
  
  private void checkTriggerTypeValidity(String triggerType) {
    if(!this.triggerTypes.contains(triggerType)) {
      throw new IllegalArgumentException("不正な値が入力されています。引数triggerTypeに" + this.triggerTypes.toString() + "以外を代入しないでください。");
    }
  }
  
  private <K, V> K getKey(Map<K, V> map, V value) {
    return map.entrySet().stream()
      .filter(entry -> value.equals(entry.getValue()))
      .findFirst().map(Map.Entry::getKey)
      .orElse(null);
  }
}

class MousePressed implements EventTrigger {
   boolean isFireCondition() {
     if(WatchMouse.checkMousePressed()) return true;
     return false;
   }
}

class MouseDown implements EventTrigger {
   boolean isFireCondition() {
     if(WatchMouse.checkMouseDown()) return true;
     return false;
   }
}

class MouseReleased implements EventTrigger {
   boolean isFireCondition() {
     if(WatchMouse.checkMouseReleased()) return true;
     return false;
   }
}

class DispatchEvent implements EventTrigger {
  boolean dispatcher = false;
  
  void dispatch() {
    this.dispatcher = true;
  };
  
  boolean isFireCondition() {
    if(dispatcher) {
      dispatcher = false;
      return true;
    }
    
    return false;
  }
}
