import java.util.Arrays;
import java.util.Map;
import java.util.HashMap;
import java.util.HashSet;

static class WatchKey {
  //Character = watch input key
  //String = triggerType
  private static HashMap<Character, String> keyStates = new HashMap<Character, String>();
  static final HashSet<String> stateTypes = new HashSet<String>() {{
    add("pressed");
    add("released");
    add("down");
    add("up");
  }};
  
  static String getKeyState(char checkKey) {
    if (keyStates.containsKey(checkKey)) {
      return keyStates.get(checkKey);
    }
    
    return "up";
  }
  
  static boolean checkKeyPressed() {
    if(keyStates.containsValue("pressed")) return true;
    return false;
  }
  
  static boolean checkKeyDown() {
    if(keyStates.containsValue("pressed")) return true;
    if(keyStates.containsValue("down")) return true;
    return false;
  }
  
  static boolean checkKeyReleased() {
    if(keyStates.containsValue("released")) return true;
    return false;
  }
  
  static void update() {
    for(String keyState : keyStates.values()) {
      checkStateTypeValidity(keyState);
    }
    
    keyStates.entrySet().stream()
        .filter(entry -> entry.getValue().equals("pressed"))
        .forEach(entry -> entry.setValue("down"));
    
    keyStates.entrySet()
        .removeIf(entry -> entry.getValue().equals("released"));     
  }
  
  static void updateKeyPressed(char pressedKey) {
    keyStates.putIfAbsent(pressedKey, "pressed");
  }
  
  static void updateKeyReleased(char releasedKey) {
    keyStates.put(releasedKey, "released");
  }
  
  private static void checkStateTypeValidity(String stateType) {
    if(!stateTypes.contains(stateType)) {
      throw new IllegalArgumentException("不正な値が入力されています。引数triggerTypeに" + stateTypes.toString() + "以外を代入しないでください。");
    }
  }
}

static class WatchMouse {
  //Character = watch input mouse
  //String = triggerType
  private static HashMap<Integer, String> mouseStates = new HashMap<Integer, String>();
  
  //Integer = getMouseStateにintで入力された場合の対応表。37,39,3以外の数字はcheckInputMouseTypeValidity()ではじく。
  //String = 文字で入力された場合にも対応出来るように
  static final HashMap<Integer, String> inputMouseTypes = new HashMap<Integer, String>() {{
    put(37, "left");
    put(39, "right");
    put(3, "center");
  }};
  static final HashSet<String> stateTypes = new HashSet<String>() {{
    add("pressed");
    add("released");
    add("down");
    add("up");
  }};
  
  static String getMouseState(int checkMouseButton) {
    checkInputMouseTypeValidity(checkMouseButton);
    if (mouseStates.containsKey(checkMouseButton)) {
      return mouseStates.get(checkMouseButton);
    }
    
    return "up";
  }
  
  static String getMouseState(String checkMouseButton) {
    checkInputMouseTypeValidity(checkMouseButton);
    if (mouseStates.containsKey(getKey(inputMouseTypes, checkMouseButton))) {
      return mouseStates.get(getKey(inputMouseTypes, checkMouseButton));
    }
    
    return "up";
  }
  
  static boolean checkMousePressed() {
    if(mouseStates.containsValue("pressed")) return true;
    return false;
  }
  
  static boolean checkMouseDown() {
    if(mouseStates.containsValue("pressed")) return true;
    if(mouseStates.containsValue("down")) return true;
    return false;
  }
  
  static boolean checkMouseReleased() {
    if(mouseStates.containsValue("released")) return true;
    return false;
  }
  
  static void update() {
    for(int mouseState : mouseStates.keySet()) {
      checkInputMouseTypeValidity(mouseState);
    }
    
    mouseStates.entrySet().stream()
        .filter(entry -> entry.getValue().equals("pressed"))
        .forEach(entry -> entry.setValue("down"));
    
    mouseStates.entrySet()
        .removeIf(entry -> entry.getValue().equals("released"));     
  }
  
  static void updateMousePressed(int pressedMouseButton) {
    checkInputMouseTypeValidity(pressedMouseButton);
    mouseStates.putIfAbsent(pressedMouseButton, "pressed");
  }
  
  static void updateMouseReleased(int releasedMouseButton) {
    checkInputMouseTypeValidity(releasedMouseButton);
    mouseStates.put(releasedMouseButton, "released");
  }
  
  private static void checkInputMouseTypeValidity(int inputMouseType) {
    if(!inputMouseTypes.containsKey(inputMouseType)) {
      throw new IllegalArgumentException("不正な値が入力されています。引数mouseButtonに" + inputMouseTypes.keySet() + inputMouseTypes.values() + "以外を代入しないでください。");
    }
  }
  
  private static void checkInputMouseTypeValidity(String inputMouseType) {
    if(!inputMouseTypes.containsKey(getKey(inputMouseTypes, inputMouseType))) {
      throw new IllegalArgumentException("不正な値が入力されています。引数mouseButtonに" + inputMouseTypes.keySet() + inputMouseTypes.values() + "以外を代入しないでください。");
    }
  }
  
  private static <K, V> K getKey(Map<K, V> map, V value) {
    return map.entrySet().stream()
      .filter(entry -> value.equals(entry.getValue()))
      .findFirst().map(Map.Entry::getKey)
      .orElse(null);
  }
}
