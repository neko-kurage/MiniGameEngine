World world;
Entity object;

UIEntity UI;
UIEntity UI2;
UIEntity UI3;
SkinCircleButton skin;
SkinCircleButton skin2;
SkinCircleButton skin3;
CircleCollider uiCollision;

void setup() {
  size(600, 600, P3D);
  
  world = new World();

  skin = new SkinCircleButton(60, 40, 4, 255);
  skin.setHoverStyle(80, 40, 8, 255);
  skin.setTween(500);
  
  skin2 = new SkinCircleButton(60, 40, 4, 255);
  skin2.setHoverStyle(80, 40, 8, 255);
  skin2.setTween(500);
  
  skin3 = new SkinCircleButton(60, 40, 4, 255);
  skin3.setHoverStyle(80, 40, 8, 255);
  skin3.setTween(500);

  UI = new UIEntity(new CircleCollider(new PVector(0, 0), 60)); 
  UI.position = new PVector(width / 2, height / 2);
  UI.setSkin(skin);

  UI2 = new UIEntity(new CircleCollider(new PVector(0, 0), 60));
  UI2.position = new PVector(width * 0.2, height / 2);
  UI2.setSkin(skin2);

  UI3 = new UIEntity(new CircleCollider(new PVector(0, 0), 60));
  UI3.position = new PVector(width * 0.8, height / 2);
  UI3.setSkin(skin3);
  
  world.addEntity(UI);
  world.addEntity(UI2);
  world.addEntity(UI3);
  
  Test test = new Test(1, 1, 2);
  test.printTest();
}

void draw() {
  background(0);
  
  println(UI.getHoverState());
  
  print(WatchMouse.mouseStates);
  println(WatchKey.keyStates);
  
  world.update();
  world.display();
  
  WatchKey.update();
  WatchMouse.update();
}

void keyPressed() {
  WatchKey.updateKeyPressed(key);
}

void keyReleased() {
  WatchKey.updateKeyReleased(key);
}

void mousePressed() {
  WatchMouse.updateMousePressed(mouseButton);
}

void mouseReleased() {
  WatchMouse.updateMouseReleased(mouseButton);
}

class Test {
  float[] num;
  
  Test(float... num) {
    this.num = num;
  }
  
  void printTest() {
    print(Arrays.toString(num));
  }
}
